import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';
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
          title: Text('settings'.tr()),
          onTap: () {
            Navigator.pop(context);
            context.push(SwitchLanguageScreen.routeName);
          },
        ),


        ListTile(
          title: Text("Scheduler screen"),
          onTap: () {
            Navigator.pop(context);
            context.push(SchedulerScreen.routeName);
          },
        ),
      ],
    ),
  );
}

//TODO: logical bug
// if the user pushed same page twice the back button will get him to same page
