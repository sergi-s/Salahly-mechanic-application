import 'dart:io';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:salahly_mechanic/widget/appbar_widget.dart';
import 'package:salahly_mechanic/widget/button_widget.dart';
import 'package:salahly_mechanic/widget/profile_widget.dart';
import 'package:salahly_mechanic/widget/textfield_widget.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_drawer.dart';
import 'package:salahly_models/salahly_models.dart';

class MechanicEditProfilePage extends StatefulWidget {
  const MechanicEditProfilePage({Key? key}) : super(key: key);
  static final routeName = "/edit_profile_page";

  @override
  _MechanicEditProfilePageState createState() =>
      _MechanicEditProfilePageState();
}

class _MechanicEditProfilePageState extends State<MechanicEditProfilePage> {
  Mechanic user = Mechanic(
    name: '',
    phoneNumber: '',
    email: '',
  );

  @override
  Widget build(BuildContext context) => ThemeSwitchingArea(
        child: Builder(
          builder: (context) => Scaffold(
            backgroundColor: const Color(0xFFd1d9e6),
            appBar: salahlyAppBar(context, title: 'edit_profile'.tr()),
            drawer: salahlyDrawer(context),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 32),
              physics: BouncingScrollPhysics(),
              children: [
                ProfileWidget(
                  imagePath: user.avatar != null? (user.avatar!) :"",
                  isEdit: true,
                  onClicked: () async {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Full Name',
                  text: user.name != null ? user.name! : '',
                  onChanged: (name) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: user.email != null ? user.email! : '',
                  onChanged: (email) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Location',
                  text: user.loc != null ? user.loc!.name! : '',
                  onChanged: (location) {},
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Password',
                  text: '',
                  onChanged: (password) {},
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
      onClicked: () {},
    );
