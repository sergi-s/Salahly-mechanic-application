import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../login_signup/signupscreen.dart';

class RejectedAccountsScreen extends StatefulWidget {
  static const String routeName = "/rejectedrequests";
  const RejectedAccountsScreen({Key? key}) : super(key: key);

  @override
  State<RejectedAccountsScreen> createState() => _RejectedAccountsScreen();
}

class _RejectedAccountsScreen extends State<RejectedAccountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.18,),
            // SizedBox(height: MediaQuery.of(context).size.height0.3,),
            Container(
              height: MediaQuery.of(context).size.height*0.28,
              width: MediaQuery.of(context).size.width*0.47,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/error.gif"),
                    fit: BoxFit.cover),
              ),
              // Foreground widget here
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04,),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: Text(
                  "Your Account has been rejected",
                  style: TextStyle(
                    fontSize: 18,
                    // letterSpacing: 1,
                    color: Color(0xFF193566),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.04,),
            RaisedButton(
              color: Color(0xFF193566),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ), child: Text(
              "logout".tr(),
              style: TextStyle(color: Colors.white),
            ),
              onPressed: (){

                FirebaseAuth.instance.signOut();
                context.go(LoginSignupScreen.routeName);
              },
            ) ],
        ),
      ),
    );
  }
}
