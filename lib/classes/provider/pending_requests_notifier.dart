import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/Requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';
import 'package:salahly_mechanic/widgets/notifications/message_notification.dart';
import 'package:salahly_models/models/road_side_assistance.dart';
import 'package:salahly_models/models/location.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Global for anyone to use it
final pendingRequestsProvider =
    StateNotifierProvider<PendingRequestsNotifier, List<RSA>>((ref) {
  return PendingRequestsNotifier(ref);
});

class PendingRequestsNotifier extends StateNotifier<List<RSA>> {
  PendingRequestsNotifier(this.ref) : super([]);
  final Ref ref;
  Map<String, RSA> rsaCache = {};

  // Setters

  addRSA(RSA rsa) {
    state = [...state, rsa];
  }

  _updateState() {
    state = [...state];
  }

  removeRSA(RSA rsa) {
    for (var element in state) {
      if (element.rsaID == rsa.rsaID) {
        state.remove(element);
        break;
      }
    }
    _updateState();
  }

  RSA _prepareRSA(String id) {
    if (rsaCache.containsKey(id)) {
      return rsaCache[id]!;
    }
    RSA r = _loadRequestFromDB(id,"rsa");
    addRSA(r);
    return r;
  }

  changeState() {
    // state[0].copyWith(state: RSAStates.done);
    state[0] = state[0].copyWith(state: RSAStates.done);
    _updateState();
  }

  _loadRequestFromDB(String id,String requestType) async {
    DataSnapshot dataSnapshot = await dbRef.child(requestType).child(id).get();
    // double? latitude =
    //     double.parse(dataSnapshot.child("latitude").value.toString());
    // double? longitude =
    //     double.parse(dataSnapshot.child("longitude").value.toString());
      RequestType t = RSA.stringToRequestType(requestType.toUpperCase())!;
    RSA rsa = RSA(
      state: stringToState(dataSnapshot.child("state").value.toString()),
      rsaID: dataSnapshot.key.toString(),
      requestType: t,
      // location: CustomLocation(
      //   latitude: latitude, longitude: longitude,
      //   // name: dataSnapshot.child("address").value.toString(),
      // ),
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

  denyRequest(RSA rsa) {
    rsa = rsa.copyWith(state: RSAStates.canceled);
    // dbRef
    //     .child(RSA.typeToString(rsa.requestType!).toLowerCase())
    //     .child(rsa.rsaID!)
    //     .child("mechanicsResponses")
    //     .child(FirebaseAuth.instance.currentUser!.uid)
    //     .set("denied");
    dbRef
        .child("mechanicsRequests")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(rsa.rsaID!)
        .child("state")
        .set("denied");
    removeRSA(rsa);
  }

  acceptRequest(RSA rsa) {
    rsa = rsa.copyWith(state: RSAStates.mechanicConfirmed);
    // dbRef
    //     .child(RSA.typeToString(rsa.requestType!).toLowerCase())
    //     .child(rsa.rsaID!)
    //     .child("mechanicsResponses")
    //     .child(FirebaseAuth.instance.currentUser!.uid)
    //     .set("accepted");
    dbRef
        .child("mechanicsRequests")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(rsa.rsaID!)
        .child("state")
        .set("accepted");
    state.forEach((element) {
      if (element == rsa) {
        removeRSA(element);
        //ADD IN ONGOING PROVIDER
        ref.watch(ongoingRequestsProvider.notifier).addRSA(rsa);
      }
    });
  }

  bool onTopOverlay = false;



  List<RSA> doneRSA = [];

  listenRequestsFromDatabase() async {
    //need to be refactored to listen only to new requests
    DatabaseReference requestsRef = FirebaseDatabase.instance
        .ref()
        .child("mechanicsRequests")
        .child(FirebaseAuth.instance.currentUser!.uid);
    print(FirebaseAuth.instance.currentUser!.uid);

    // await rsaNotifier.requestRSA();
    requestsRef.onValue.listen((eventAllRequests) async {
      for (var event in eventAllRequests.snapshot.children) {
        String rsaID = event.key.toString();
        // print("LISTENER");
        // print("${event.value}");
        if (event.value != null) {
          // print("data not null");
          DataSnapshot dataSnapshot = event;
          // If it is first time read
          if (!rsaCache.containsKey(rsaID)) {
            RSA r = await _loadRequestFromDB(rsaID,event.child("type").value.toString());
            if (event.child("state").value == "pending") {
              addRSA(r);
              print(state.length);
              if (!onTopOverlay) {
                onTopOverlay = true;
                showSimpleNotification(
                  Text("received_a_new_request".tr()),
                  trailing: Builder(builder: (context) {
                    return
                      // TextButton(
                      //   onPressed: () {
                      //     onTopOverlay = false;
                      //     // navigatorKey.currentState!.pushNamed(TestScreenFoula.routeName);
                      //     context.push(PENDINGVIEW.routeName);
                      //     OverlaySupportEntry.of(context)!.dismiss();
                      //   },
                      //   child: Text("go_to_request".tr(),
                      //       style: const TextStyle(color: Colors.white)));
                      Container(
                        width: MediaQuery.of(context).size.width * 0.38,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                onTopOverlay = false;
                                // navigatorKey.currentState!.pushNamed(TestScreenFoula.routeName);
                                context.push(PENDINGVIEW.routeName);
                                OverlaySupportEntry.of(context)!.dismiss();
                              },
                              child: Text("go_to_request".tr(),
                                  style: const TextStyle(color: Colors.white))),
                          IconButton(onPressed: () {
                            onTopOverlay = false;
                            OverlaySupportEntry.of(context)!.dismiss();
                          }, icon: const Icon(Icons.close, color: Colors.white)),
                        ],
                    ),
                      );
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
            }else if(event.value == "accepted"){
              ref.watch(ongoingRequestsProvider.notifier).addRSA(r);
            }else if(event.value == "done"){
              //add in shared preferences
              doneRSA.add(r);
            }
          } else {
            // Already exists
            if (dataSnapshot.value.toString() == "ongoing") {
              // print("Mechanic accepted request");
            }
            if (dataSnapshot.value.toString() == "pending") {
              // print("Mechanic received request");
            }
            if (dataSnapshot.value.toString() == "canceled") {
              // print("User canceled RSA");
            }
          }
        }
      }
    });
  }
}
