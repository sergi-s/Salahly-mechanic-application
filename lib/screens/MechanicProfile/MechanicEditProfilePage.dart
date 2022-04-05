import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:salahly_mechanic/model/user.dart';
import 'package:salahly_mechanic/utils/user_preferences.dart';
import 'package:salahly_mechanic/widget/appbar_widget.dart';
import 'package:salahly_mechanic/widget/button_widget.dart';
import 'package:salahly_mechanic/widget/profile_widget.dart';
import 'package:salahly_mechanic/widget/textfield_widget.dart';

class MechanicEditProfilePage extends StatefulWidget {
  const MechanicEditProfilePage({Key? key}) : super(key: key);
  static final routeName = "/edit_profile_page";
  @override
  _MechanicEditProfilePageState createState() => _MechanicEditProfilePageState();
}

class _MechanicEditProfilePageState extends State<MechanicEditProfilePage> {
  User user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            appBar: buildAppBar(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name,
                  onChanged: (name)  {
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email,
                  onChanged: (email)  {
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Mechanic Experience',
                  text: user.about,
                  onChanged: (about)  {

                  },
                ),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton()),
              ],
            ),
          ),
        ),
      );
}
Widget buildUpgradeButton() => ButtonWidget(
  text: 'Save Edit'.tr(),
  onClicked: () {
  },
);
