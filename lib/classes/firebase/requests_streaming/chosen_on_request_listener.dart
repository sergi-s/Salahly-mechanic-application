

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

listenToBeingChosen(RSA rsa, Ref ref) {
  PendingRequestsNotifier pendingNotifier = ref.watch(pendingRequestsProvider.notifier);
  dbRef
      .child("mechanicsRequests")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child(rsa.rsaID!)
      .child("state")
      .onChildChanged
      .listen((event) {
        print("chosen on request listener");
    if (event.snapshot.value == null) return;
    if (event.snapshot.value == "chosen") {
      print("chosen listener inside if");
      // Mechanic/Provider was chosen
      pendingNotifier.removeRSA(rsa);
      ref.watch(ongoingRequestsProvider.notifier).addRSA(rsa);
    } else if(event.snapshot.value == "not chosen") {
      // Mechanic/Provider was rejected
      pendingNotifier.removeRSA(rsa);
    }
  });
}