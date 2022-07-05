import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:salahly_mechanic/utils/check_user_account_state.dart';

class InActiveAccountsScreen extends StatelessWidget {
  InActiveAccountsScreen({Key? key,required this.accountState}) : super(key: key);
  AccountStates accountState;
  static const routeName = '/inactiveAccountsScreen';


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            stateDescription(accountState),
            style: const TextStyle(fontSize: 40),
          ),
          ElevatedButton(onPressed: ()async{
            await dbRef.child("FCMTokens").child(FirebaseAuth.instance.currentUser!.uid).remove();
            await FirebaseAuth.instance.signOut();
            context.go(LoginSignupScreen.routeName);
          }, child: Text('logout'.tr()),),
        ],
      ),
    );
  }
}
