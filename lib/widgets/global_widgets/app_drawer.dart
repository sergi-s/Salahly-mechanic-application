import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/Requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';
import 'package:salahly_mechanic/screens/homepage/switch.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:salahly_mechanic/screens/requests/allscreens.dart';
import 'package:salahly_mechanic/screens/scheduler/scheduler_screen.dart';
import 'package:salahly_mechanic/screens/switchLanguage.dart';

Widget salahlyDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/wavy shape copy.png'),
                  alignment: Alignment.topCenter,
                  fit: BoxFit.fill),
              color: Colors.transparent),
          child: Text(''),
        ),
        ListTile(
          title: const Text(
            "Home screen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
          onTap: () {
            context.push(HomeScreen.routeName);
          },
        ),
        ListTile(
          title: const Text(
            "Scheduler screen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
          onTap: () {
            context.push(SchedulerScreen.routeName);
          },
        ),
        ListTile(
          title: const Text(
            "Set availability",
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
          onTap: () {
            context.push(Switcher.routeName);
          },
        ),
        ListTile(
          title: const Text(
            "PendingRequests screen",
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
          onTap: () {
            context.push(PendingRequests.routeName);
          },
        ),
        ListTile(
          title: const Text(
            'Ongoing UI screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
          onTap: () {
            context.push(OnGoingRequests.routeName);
          },
        ),
        ListTile(
          title: const Text(
            'Change language screen',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            context.push(SwitchLanguageScreen.routeName);
          },
        ),
        ListTile(
          title: const Text(
            'Log out',
            style: TextStyle(fontWeight: FontWeight.bold),
          ).tr(),
          onTap: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                        "Are you sure you want to log out?"),
                    title: Text("Warning"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel")),
                      TextButton(
                          onPressed: () async{

                            await dbRef.child("FCMTokens").child(FirebaseAuth.instance.currentUser!.uid).remove();
                            await FirebaseAuth.instance.signOut();
                            context.go(LoginSignupScreen.routeName);
                          },
                          child: Text("confirm")),

                    ],
                  );
                });

          },
        ),

      ],
    ),
  );
}

//TODO: logical bug
// if the user pushed same page twice the back button will get him to same page
