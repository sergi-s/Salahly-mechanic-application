import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:salahly_mechanic/classes/firebase/controllers/request_controller.dart';
import 'package:salahly_mechanic/classes/firebase/requests_streaming/chosen_on_request_listener.dart';
import 'package:salahly_mechanic/classes/firebase/requests_streaming/requests_listener.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/Requests/allscreens.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_mechanic/utils/requests_memory_caching.dart';
import 'package:salahly_mechanic/widgets/notifications/message_notification.dart';
import 'package:salahly_models/abstract_classes/user.dart';
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

  // Setters

  addRSA(RSA rsa) {
    if (state.contains(rsa)) return;
    state = [...state, rsa];
  }

  _updateState() {
    state = [...state];
  }

  RSA? removeRSA(RSA rsa) {
    RSA? el;
    for (var element in state) {
      if (element.rsaID == rsa.rsaID) {
        el = element;
        state.remove(element);
        break;
      }
    }
    _updateState();
    return el;
  }

  RSA? removeRSAById(String rsaID) {
    RSA? el;
    for (var element in state) {
      if (element.rsaID == rsaID) {
        el = element;
        state.remove(element);
        break;
      }
    }
    _updateState();
    return el;
  }

  RSA _prepareRSA(String id) {
    if (rsaCache.containsKey(id)) {
      return rsaCache[id]!;
    }
    RSA r = loadRequestFromDB(id, "rsa");
    addRSA(r);
    return r;
  }

  changeState() {
    // state[0].copyWith(state: RSAStates.done);
    state[0] = state[0].copyWith(state: RSAStates.done);
    _updateState();
  }

  denyRequest(RSA rsa) {
    rsa = rsa.copyWith(state: RSAStates.canceled);
    var reqVar = "";
    if (userType == Type.provider) {
      reqVar = "providersRequests";
    } else if (userType == Type.mechanic) {
      reqVar = "mechanicsRequests";
    } else {
      return;
    }
    // dbRef
    //     .child(RSA.typeToString(rsa.requestType!).toLowerCase())
    //     .child(rsa.rsaID!)
    //     .child("mechanicsResponses")
    //     .child(FirebaseAuth.instance.currentUser!.uid)
    //     .set("denied");
    dbRef
        .child(reqVar)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(rsa.rsaID!)
        .child("state")
        .set("rejected");
    removeRSA(rsa);
  }

  Future<bool> acceptRequest(RSA rsa) async {
    var reqVar = "";
    if (userType == Type.provider) {
      reqVar = "providersRequests";
      rsa = rsa.copyWith(state: RSAStates.providerConfirmed);
    } else if (userType == Type.mechanic) {
      reqVar = "mechanicsRequests";
      rsa = rsa.copyWith(state: RSAStates.mechanicConfirmed);
    } else {
      return false;
    }
    dbRef
        .child(reqVar)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(rsa.rsaID!)
        .child("state")
        .set("accepted");
    if (rsa.requestType == RequestType.RSA) {
      await Future.delayed(const Duration(seconds: 3));
      removeRSA(rsa);
      dbRef
          .child(reqVar)
          .child(FirebaseAuth.instance.currentUser!.uid)
          .child(rsa.rsaID!)
          .child("state")
          .get()
          .then((value) async {
        if (value.value != "timeout") {
          ref.watch(ongoingRequestsProvider.notifier).addRSA(rsa);
          return true;
        } else {
          removeRSAById(rsa.rsaID!);
          return false;
        }
      });
    } else {
      removeRSA(rsa);
      addRSA(rsa);
      return true;
    }
    return false;
  }

  List<RSA> doneRSA = [];
}
