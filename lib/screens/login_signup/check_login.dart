import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:salahly_mechanic/screens/requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';

class CheckLogin extends StatelessWidget {
  const CheckLogin({Key? key}) : super(key: key);
  static const routeName = "/checklogin";
  @override
  Widget build(BuildContext context) {
    // FirebaseAuth.instance.signOut();
    if (FirebaseAuth.instance.currentUser == null) {
      context.go(LoginSignupScreen.routeName);
    } else {
      // context.go(HomeScreen.routeName);
      // context.go(TestScreenFoula.routeName);
      context.go(OngoingScreenDummy.routeName);
    }
    return const Scaffold(body: SafeArea(child: Text("Checking logged in user error")));
  }
}
