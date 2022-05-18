import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/login_signup/after_login_response.dart';

enum AccountStates {
  ACTIVE,
  INACTIVE,
  PENDING,
  BANNED,
  LOGGED_OUT,
  NO_DATA,
}

String stateDescription(AccountStates accountState) {
  switch (accountState) {
    case AccountStates.INACTIVE:
      return "Your account is inactive, please contact support";
    case AccountStates.BANNED:
      return "Your account is banned";
    case AccountStates.ACTIVE:
      return "Your account is working normally";
    case AccountStates.LOGGED_OUT:
      return "You are logged out, please login again";
    case AccountStates.NO_DATA:
      return "Your account has no data, please register your data";
    case AccountStates.PENDING:
      return "Your registration request is pending, please wait until it is approved";
  }
}

String stateRedirect(AccountStates accountState){
  switch (accountState) {
    case AccountStates.INACTIVE:
      return "";
    case AccountStates.BANNED:
      return InActiveAccountsScreen.routeName;
    case AccountStates.ACTIVE:
      return "";
    case AccountStates.LOGGED_OUT:
      return "";
    case AccountStates.NO_DATA:
      return "";
    case AccountStates.PENDING:
      return "";
  }
}

AccountStates getAccountState() {
  if (FirebaseAuth.instance.currentUser != null) {
    dbRef
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('accountState')
        .get()
        .then((snapShot) {
      if (snapShot.value != null) {
        if (snapShot.value.toString() == 'active') {
          return AccountStates.ACTIVE;
        } else if (snapShot.value.toString() == 'banned') {
          return AccountStates.BANNED;
        } else if (snapShot.value.toString() == 'pending') {
          return AccountStates.PENDING;
        }
      } else {
        return AccountStates.NO_DATA;
      }
    });
    return AccountStates.ACTIVE;
  } else {
    return AccountStates.LOGGED_OUT;
  }
}
