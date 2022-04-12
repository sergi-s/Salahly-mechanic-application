import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

AppBar buildAppBar(BuildContext context) {

  return AppBar(
    leading: BackButton(),
    title: Text('Mechanic Profile Page'),
    centerTitle: true,
    backgroundColor: Color(0xff193566),
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () async {
          if (await confirm(
            context,
            title: const Text('Confirm').tr(),
            content: const Text('Would you like to LogOut?').tr(),
            textOK: const Text('Yes').tr(),
            textCancel: const Text('No').tr(),
          )) {
            return print('pressedOK');
          }
          return print('pressedCancel');
        },
        icon: const Icon(
          Icons.logout,
          size: 35,
          color: Colors.red,
        ),
      ),
    ],
  );
}
