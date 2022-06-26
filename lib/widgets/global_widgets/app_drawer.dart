import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/MechanicProfile/MechanicProfilePage.dart';
import 'package:salahly_mechanic/screens/Requests/done_requests.dart';
import 'package:salahly_mechanic/screens/Requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/screens/homepage/switch.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
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
          title:  Text(
            "scheduler_screen".tr(),
            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
          ),
          onTap: () {
            context.push(SchedulerScreen.routeName);
          },
        ),

        ListTile(
          title:  Text(
            "set_availability".tr(),
            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
          ),
          onTap: () {
            context.push(Switcher.routeName);
          },
        ),

        ListTile(
          title:  Text(
            "pending_requests_screen".tr(),
            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
          ),
          onTap: () {
            context.push(PendingRequests.routeName);
          },
        ),
        ListTile(
          title:  Text(
            "ongoing_screen".tr(),
            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
          ),
          onTap: () {
            context.push(OnGoingRequests.routeName);
          },
        ),

        // ListTile(
        //   title: const Text(
        //     "done_profile",
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold, color: Color(0xff193566)),
        //   ).tr(),
        //   onTap: () {
        //     context.push(DoneRequests.routeName);
        //   },
        // ),
        ListTile(
          title:  Text(
            "view_profile".tr(),
            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
          ),
          onTap: () {
            context.push(MechanicProfilePage.routeName);
          },
        ),
        // ListTile(
        //   title: const Text(
        //     'Ongoing UI screen',
        //     style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
        //   ).tr(),
        //   onTap: () {
        //     context.push(OnGoingRequests.routeName);
        //   },
        // ),
        ListTile(
          title: const Text(
            'change_language_screen',
            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
          ),
          onTap: () {
            context.push(SwitchLanguageScreen.routeName);
          },
        ),
        ListTile(
          title:  Text(
            'logout'.tr(),
            style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xff193566)),
          ),
          onTap: () async {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                        "sure_to_log_out".tr()),
                    title: Text("warning".tr()),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("cancel".tr())),
                      TextButton(
                          onPressed: () async{

                            await dbRef.child("FCMTokens").child(FirebaseAuth.instance.currentUser!.uid).remove();
                            await FirebaseAuth.instance.signOut();
                            context.go(LoginSignupScreen.routeName);
                          },
                          child: Text("confirm".tr())),

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
