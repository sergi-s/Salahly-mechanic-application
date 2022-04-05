import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';
import 'package:salahly_mechanic/widgets/notifications/message_notification.dart';
import 'package:salahly_models/models/road_side_assistance.dart';
import 'package:salahly_models/models/location.dart';
import 'package:go_router/go_router.dart';
// import 'package:slahly/classes/models/road_side_assistance.dart';

// Global for anyone to use it
final ongoingRequestsProvider =
    StateNotifierProvider<OngoingRequestsNotifier, List<RSA>>((ref) {
  return OngoingRequestsNotifier(ref);
});

class OngoingRequestsNotifier extends StateNotifier<List<RSA>> {
  OngoingRequestsNotifier(this.ref) : super([]);
  final Ref ref;
  Map<String, RSA> rsaCache = {};

  // Setters
  assignRSA() {}

  addRSA(RSA rsa) {
    state = [...state, rsa];
  }

  _updateState() {
    //TODO to be tested
    state[0] = state[0].copyWith();
  }

  removeRSA(RSA rsa) {
    state.remove(rsa);
    _updateState();
  }

  RSA _prepareRSA(String id) {
    if (rsaCache.containsKey(id)) {
      return rsaCache[id]!;
    }
    RSA r = _loadRSAFromDB(id);
    addRSA(r);
    return r;
  }

  _loadRSAFromDB(String id) async {
    DataSnapshot dataSnapshot = await dbRef.child("rsa").child(id).get();
    double latitude =
        double.parse(dataSnapshot.child("latitude").value.toString());
    double longitude =
        double.parse(dataSnapshot.child("longitude").value.toString());
    RSA rsa = RSA(
      state: stringToState(dataSnapshot.child("state").value.toString()),
      rsaID: dataSnapshot.key.toString(),
      location: CustomLocation(
        latitude: latitude, longitude: longitude,
        // name: dataSnapshot.child("address").value.toString(),
      ),
      // report: Report()
    );
    rsaCache[rsa.rsaID!] = rsa;
    return rsa;
  }

  RSAStates stringToState(String id) {
    if (id == RSA.stateToString(RSAStates.waitingForMechanicResponse)) {
      return RSAStates.waitingForMechanicResponse;
    } else if (id == RSA.stateToString(RSAStates.waitingForProviderResponse)) {
      RSAStates.waitingForProviderResponse;
    }
    return RSAStates.canceled;
  }

  bool onTopOverlay = false;

  listenRequestsFromDatabase() async {
    DatabaseReference requestsRef = FirebaseDatabase.instance
        .ref()
        .child("mechanicsRequests")
        .child(FirebaseAuth.instance.currentUser!.uid);
    print(FirebaseAuth.instance.currentUser!.uid);

    // await rsaNotifier.requestRSA();
    requestsRef.onValue.listen((eventAllRequests) async {
      for (var event in eventAllRequests.snapshot.children) {
        String rsaID = event.key.toString();
        print("LISTENER");
        print("${event.value}");
        if (event.value != null) {
          print("data not null");
          DataSnapshot dataSnapshot = event;
          // If it is first time read
          if (!rsaCache.containsKey(rsaID)) {
            RSA r = await _loadRSAFromDB(rsaID);
            addRSA(r);
            if (event.value == "pending") {
              if(!onTopOverlay) {
                onTopOverlay = true;
                showSimpleNotification(
                Text("received_a_new_request".tr()),
                trailing: Builder(builder: (context) {
                  return TextButton(
                      onPressed: () {
                        onTopOverlay = false;
                        // navigatorKey.currentState!.pushNamed(TestScreenFoula.routeName);
                        context.go(TestScreenFoula.routeName);
                        OverlaySupportEntry.of(context)!.dismiss();
                      },
                      child: Text("go_to_request".tr(),
                          style: const TextStyle(color: Colors.white)));
                }),
                background: Colors.green,
                autoDismiss: false,
                slideDismissDirection: DismissDirection.up,
              );
              }
              /*
              Custom notification
              showOverlayNotification(
                (context) {
                  return MessageNotification(
                    onReplay: () {
                      OverlaySupportEntry.of(context)?.dismiss(); //use OverlaySupportEntry to dismiss overlay
                      navigatorKey.currentState!.pushNamed(OngoingScreenDummy.routeName);
                    },
                  );
                  // return Row(children: [
                  //   Text("received_a_new_request".tr()),
                  //   ElevatedButton(
                  //       onPressed: () {
                  //         navigatorKey.currentState!
                  //             .pushNamed(OngoingScreenDummy.routeName);
                  //       },
                  //       child: Text("go_to_request".tr()))
                  // ]);
                },
              );*/
              // showSimpleNotification(
              //     Row(
              //       children: [
              //         //TODO put translation
              //         Text("received_a_new_request".tr()),
              //         ElevatedButton(
              //             onPressed: () {
              //               navigatorKey.currentState!
              //                   .pushNamed(OngoingScreenDummy.routeName);
              //             },
              //             child: Text("go_to_request".tr()))
              //       ],
              //     ),
              //     background: Colors.green);
            }
          } else {
            // Already exists
            if (dataSnapshot.value.toString() == "ongoing") {
              print("Mechanic accepted new request");
            }
            if (dataSnapshot.value.toString() == "pending") {
              print("Mechanic received new request");
            }
          }
        }
      }
    });
  }

  updateRSA() {}
}
