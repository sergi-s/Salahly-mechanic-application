import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:salahly_mechanic/classes/firebase/controllers/request_controller.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_mechanic/utils/requests_memory_caching.dart';
import 'package:salahly_models/abstract_classes/user.dart';
import 'package:salahly_models/models/road_side_assistance.dart';
import 'package:easy_localization/easy_localization.dart';

bool onTopOverlay = false;
bool alreadyListening = false;

listenRequestsFromDatabaseByNotifiers(PendingRequestsNotifier pendingNotifier,
    OngoingRequestsNotifier ongoingRequestsNotifier) async {
  // PendingRequestsNotifier pendingNotifier = ref.watch(pendingRequestsProvider.notifier);
  //need to be refactored to listen only to new requests
  print("Already listening? $alreadyListening");

  if (alreadyListening) return;
  var reqVar = "";
  userType ??= await getUserType();
  if (userType == Type.provider) {
    reqVar = "providersRequests";
  } else if (userType == Type.mechanic) {
    reqVar = "mechanicsRequests";
  } else {
    return;
  }
  alreadyListening = true;
  DatabaseReference requestsRef = FirebaseDatabase.instance
      .ref()
      .child(reqVar)
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
          RSA r = await loadRequestFromDB(
              rsaID, event.child("type").value.toString());
          if (event.child("state").value == "pending") {
              pendingNotifier.addRSA(r);
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
                              context.push(PendingRequests.routeName);
                              OverlaySupportEntry.of(context)!.dismiss();
                            },
                            child: Text("go_to_request".tr(),
                                style: const TextStyle(color: Colors.white))),
                        IconButton(
                            onPressed: () {
                              onTopOverlay = false;
                              OverlaySupportEntry.of(context)!.dismiss();
                            },
                            icon: const Icon(Icons.close, color: Colors.white)),
                      ],
                    ),
                  );
                }),
                background: Colors.green,
                autoDismiss: false,
                slideDismissDirection: DismissDirection.up,
              );
            }
          } else if ((event.child("state").value == "chosen") ||
             ( event.child("state").value == "accepted" && event.child('type').value == 'rsa')) {
            ongoingRequestsNotifier.addRSA(r);
          } else if (event.child("state").value == "done") {
            //add in shared preferences
            pendingNotifier.doneRSA.add(r);
          }
          else if (event.child("state").value == "accepted") { //automatically tests wsa,tta
            //add in shared preferences
            pendingNotifier.addRSA(r);
          }
        } else {
          // Already exists
          if (event.child("state").value == "chosen") {
            RSA? r = pendingNotifier.removeRSAById(rsaID);
            if (r != null) ongoingRequestsNotifier.addRSA(r);
          } else if (event.child("state").value == "not chosen" ||
              event.child("state").value == "timeout") {
            // Mechanic/Provider was rejected
            pendingNotifier.removeRSAById(rsaID);
          } else if (event.child("state").value == "ongoing") {
            // print("Mechanic accepted request");
          } else if (event.child("state").value.toString() == "canceled") {
            RSA? r = ongoingRequestsNotifier.removeRSAById(rsaID);
            r ??= pendingNotifier.removeRSAById(rsaID);
          }
          // if (dataSnapshot.value.toString() == "done") {
          //   RSA? r = ongoingRequestsNotifier.removeRSAById(rsaID);
          //   if(r != null) pendingNotifier.doneRSA.add(r);
          // }
        }
      }
    }
  });
}
