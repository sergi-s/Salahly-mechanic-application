import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/login_signup/after_login_response.dart';
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/themes.dart';

enum AccountStates {
  ACTIVE,
  INACTIVE,
  PENDING,
  BANNED,
  LOGGED_OUT,
  NO_DATA,
  REJECTED
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
    case AccountStates.REJECTED:
      return "Your registration was rejected";
  }
}

String stateRedirect(AccountStates accountState) {
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
      return Registration.routeName;
    case AccountStates.PENDING:
      return "";

    case AccountStates.REJECTED:
      return "";
  }
}

Future<AccountStates> getAccountState() async {
  AccountStates? k;
  if (FirebaseAuth.instance.currentUser != null) {
    await dbRef
        .child('users')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('accountState')
        .once()
        .then((event) {
      // print("a7eh");
      // print(event.snapshot.value.toString());
      // print('check: ${event.snapshot.value != null}');
      if (event.snapshot.value != null) {
        if (event.snapshot.value.toString() == 'active') {
          k = AccountStates.ACTIVE;
          return AccountStates.ACTIVE;
        } else if (event.snapshot.value.toString() == 'banned') {
          k = AccountStates.BANNED;
          return AccountStates.BANNED;
        } else if (event.snapshot.value.toString() == 'pending') {
          print("peeeeeeeeeeeeeending");
          k = AccountStates.PENDING;
          return AccountStates.PENDING;
        }
        else if(event.snapshot.value.toString() == 'rejected'){
          k = AccountStates.REJECTED;
          return AccountStates.REJECTED;
        }
      } else {
        k = AccountStates.NO_DATA;
        return k;
      }
    });
    if (k == null)
      return AccountStates.ACTIVE;
    else
      return k!;
  } else {
    return AccountStates.LOGGED_OUT;
  }
}
