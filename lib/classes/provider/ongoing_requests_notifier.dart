import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  finishRSA(RSA rsa){

    removeRSA(rsa);
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
