import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_models/models/road_side_assistance.dart';
import 'package:salahly_models/models/location.dart';

// Global for anyone to use it
final ongoingRequestsProvider =
    StateNotifierProvider<OngoingRequestsNotifier, List<RSA>>((ref) {
  return OngoingRequestsNotifier(ref);
});

class OngoingRequestsNotifier extends StateNotifier<List<RSA>> {
  OngoingRequestsNotifier(this.ref) : super([]);
  final Ref ref;

  // Setters

  addRSA(RSA rsa) {
    state = [...state, rsa];
  }

  finishRSA(RSA rsa, PendingRequestsNotifier pendingRequestsNotifier){
    RSA? r = removeRSA(rsa);
      if(r != null) PendingRequestsNotifier.doneRSA.add(r);
  }

  finishRSAById(String rsaID, PendingRequestsNotifier pendingRequestsNotifier){
      RSA? r = removeRSAById(rsaID);
      if(r != null) PendingRequestsNotifier.doneRSA.add(r);
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

  // changeState() {
  //   // state[0].copyWith(state: RSAStates.done);
  //   state[0] = state[0].copyWith(state: RSAStates.done);
  //   _updateState();
  // }

  RSAStates stringToState(String id) {
    if (id == RSA.stateToString(RSAStates.waitingForMechanicResponse)) {
      return RSAStates.waitingForMechanicResponse;
    } else if (id == RSA.stateToString(RSAStates.waitingForProviderResponse)) {
      RSAStates.waitingForProviderResponse;
    }
    return RSAStates.canceled;
  }

}
