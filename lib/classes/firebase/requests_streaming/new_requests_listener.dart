import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
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
bool _alreadyListening = false;

listenRequestsFromDatabaseByNotifiersNEW(PendingRequestsNotifier pendingNotifier,
    OngoingRequestsNotifier ongoingRequestsNotifier) async {
  // PendingRequestsNotifier pendingNotifier = ref.watch(pendingRequestsProvider.notifier);
  //need to be refactored to listen only to new requests
  // print("Already listening? $_alreadyListening");

  if (_alreadyListening) return;
  var reqVar = "";
  userType ??= await getUserType();
  if (userType == Type.provider) {
    reqVar = "providersRequests";
  } else if (userType == Type.mechanic) {
    reqVar = "mechanicsRequests";
  } else {
    return;
  }
  _alreadyListening = true;
  DatabaseReference requestsRef = FirebaseDatabase.instance
      .ref()
      .child(reqVar)
      .child(FirebaseAuth.instance.currentUser!.uid)
      // .orderByChild("state")
      // .equalTo(FirebaseAuth.instance.currentUser!.uid)
      ;

  print(FirebaseAuth.instance.currentUser!.uid);

  // await rsaNotifier.requestRSA();
  requestsRef.onValue.listen((eventAllRequests) async {
    for (var event in eventAllRequests.snapshot.children) {
      String rsaID = event.key.toString();
      // print("LISTENER");
      // print("${event.value}");
      if (event.value == null) {
        continue;
      }
        // print("data not null");
        // DataSnapshot dataSnapshot = event;

       


        // If it is first time read
        if (!rsaCache.containsKey(rsaID)) {

           //Load request data from DB
        
        // if request type is not avaialbale return
        if(event.child("type").value == null) continue;

          RSA? rr = await loadRequestFromDB(
              rsaID, event.child("type").value.toString());
          RSA request;
          // if request doesn't exist, return
          if (rr == null) {
            continue;
          } else {
            request = rr;
          }
          
          print("${request.state}   ${request.requestType}   ${request.rsaID}");
          if (event.child("state").value == "pending") {
            // &&
            // ((userType == Type.mechanic) ||
            //     (userType == Type.provider && (
            //         r.requestType == RequestType.TTA ||
            //             r.state == RSAStates.waitingForProviderResponse)))
            // print("check if they are pending");
            if (!pendingRequestsCache.containsKey(rsaID)) {
              pendingRequestsCache[rsaID] = request;
              pendingNotifier.addRSA(request);
            } else {
              continue;
            }
            // print("Added to pending (first time) for receiver");
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
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              onTopOverlay = false;
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
          }
          // else if (event
          //     .child("state")
          //     .value == "pending" &&
          //     userType == Type.provider) {
          //   //start listener for this request when it becomes waitingForProviderResponse
          //   print(RSA.requestTypeToString(r.requestType!).toLowerCase());
          //   print(rsaID);
          //   print(r.state);
          //   dbRef
          //       .child(RSA.requestTypeToString(r.requestType!).toLowerCase())
          //       .child(rsaID)
          //       .child('state')
          //       .onValue
          //       .listen((event) {
          //     print("EVENT " + event.snapshot.value.toString());
          //     print(RSA.stringToState(event.snapshot.value.toString()));
          //     print(RSA.stringToState(event.snapshot.value.toString()) ==
          //         RSAStates.waitingForProviderResponse);
          //     if (RSA.stringToState(event.snapshot.value.toString()) ==
          //         RSAStates.waitingForProviderResponse) {
          //       pendingNotifier.addRSA(r);
          //       if (!onTopOverlay) {
          //         onTopOverlay = true;
          //         showSimpleNotification(
          //           Text("received_a_new_request".tr()),
          //           trailing: Builder(builder: (context) {
          //             return
          //               // TextButton(
          //               //   onPressed: () {
          //               //     onTopOverlay = false;
          //               //     // navigatorKey.currentState!.pushNamed(TestScreenFoula.routeName);
          //               //     context.push(PENDINGVIEW.routeName);
          //               //     OverlaySupportEntry.of(context)!.dismiss();
          //               //   },
          //               //   child: Text("go_to_request".tr(),
          //               //       style: const TextStyle(color: Colors.white)));
          //               Container(
          //                 width: MediaQuery
          //                     .of(context)
          //                     .size
          //                     .width * 0.38,
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.end,
          //                   children: [
          //                     TextButton(
          //                         onPressed: () {
          //                           onTopOverlay = false;
          //                           // navigatorKey.currentState!.pushNamed(TestScreenFoula.routeName);
          //                           context.push(PendingRequests.routeName);
          //                           OverlaySupportEntry.of(context)!.dismiss();
          //                         },
          //                         child: Text("go_to_request".tr(),
          //                             style: const TextStyle(
          //                                 color: Colors.white))),
          //                     IconButton(
          //                         onPressed: () {
          //                           onTopOverlay = false;
          //                           OverlaySupportEntry.of(context)!.dismiss();
          //                         },
          //                         icon:
          //                         const Icon(Icons.close, color: Colors.white)),
          //                   ],
          //                 ),
          //               );
          //           }),
          //           background: Colors.green,
          //           autoDismiss: false,
          //           slideDismissDirection: DismissDirection.up,
          //         );
          //       }
          //     }
          //   });
          // }
          else if (((event.child("state").value == "chosen") ||
              (event.child("state").value == "accepted" &&
                  event.child('type').value == 'rsa'))) {
            ongoingRequestsNotifier.addRSA(request);
          } else if (request.state == RSAStates.done) {
            //add in shared preferences
            // pendingNotifier.doneRSA.add(r);
            PendingRequestsNotifier.doneRSA.add(request);
          } else if (event.child("state").value == "accepted") {
            //automatically tests wsa,tta
            //add in shared preferences
            if (!pendingRequestsCache.containsKey(rsaID)) {
              if (userType == Type.mechanic) {
                RSA rsa = request.copyWith(state: RSAStates.mechanicConfirmed);
                rsaCache[request.rsaID!] = rsa;
                pendingRequestsCache[rsaID] = rsa;
                pendingNotifier.addRSA(rsa);
              } else {
                RSA rsa = request.copyWith(state: RSAStates.providerConfirmed);
                rsaCache[request.rsaID!] = rsa;
                pendingRequestsCache[rsaID] = rsa;
                pendingNotifier.addRSA(rsa);
              }
            } else {
              return;
            }
          }else {
            continue;
          }
        } else {
          print("Request in cache is being updated");
          // Already exists
          // If state received as pending but the receiver is provider so it is waiting for provider response
          if (event.child('state').value == 'pending' &&
              userType == Type.provider) {
            print(
                "Received request that is pending but now provider received it");
            RSA? rsa = rsaCache[rsaID];
            if (rsa != null) {
              if (!pendingRequestsCache.containsKey(rsaID)) {
                pendingRequestsCache[rsaID] = rsa;
                pendingNotifier.addRSA(rsa);
              } else {
                continue;
              }
              if (!onTopOverlay) {
                onTopOverlay = true;
                showSimpleNotification(
                  Text("received_a_new_request".tr()),
                  trailing: Builder(builder: (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.2,
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
                              icon:
                                  const Icon(Icons.close, color: Colors.white)),
                        ],
                      ),
                    );
                  }),
                  background: Colors.green,
                  autoDismiss: false,
                  slideDismissDirection: DismissDirection.up,
                );
              }
            }
          } else if (event.child("state").value == "chosen") {
            RSA? r = pendingNotifier.removeRSAById(rsaID);
            if (r != null) ongoingRequestsNotifier.addRSA(r);
          } else if (event.child("state").value == "not chosen" ||
              event.child("state").value == "timeout") {
            // Mechanic/Provider was rejected
            pendingNotifier.removeRSAById(rsaID);
          } else if (event.child("state").value == "ongoing") {
            // print("Mechanic accepted request");
          } else if (event.child("state").value.toString() == "cancelled" || event.child("state").value.toString() == "done") {
            RSA? r = ongoingRequestsNotifier.removeRSAById(rsaID);
            r ??= pendingNotifier.removeRSAById(rsaID);
          }
          // else if ( TODO add to done
          // rsaCache[rsaID] != null &&
          //     RSA.stringToState((await dbRef.child(RSA.requestTypeToString(rsaCache[rsaID]!.requestType!).toLowerCase()).child(rsaID)
          //         .child('state').get()).value!.toString()) == RSAStates.done
          // ) {
          //   PendingRequestsNotifier.doneRSA.add(rsaCache[rsaID]!);
          // }
          // if (dataSnapshot.value.toString() == "done") {
          //   RSA? r = ongoingRequestsNotifier.removeRSAById(rsaID);
          //   if(r != null) pendingNotifier.doneRSA.add(r);
          // }
        }
    }
  });
}
