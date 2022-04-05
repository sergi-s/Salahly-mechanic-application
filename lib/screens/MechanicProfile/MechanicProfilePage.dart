import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/model/user.dart';
import 'package:salahly_mechanic/screens/MechanicProfile/MechanicEditProfilePage.dart';
import 'package:salahly_mechanic/utils/user_preferences.dart';
import 'package:salahly_mechanic/widget/appbar_widget.dart';
import 'package:salahly_mechanic/widget/button_widget.dart';
import 'package:salahly_mechanic/widget/numbers_widget.dart';
import 'package:salahly_mechanic/widget/profile_widget.dart';
import 'package:salahly_mechanic/themes.dart';

class MechanicProfilePage extends StatelessWidget {
  static final String title = 'User Profile';
  static final routeName = "/profile_page";
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return ThemeProvider(
      initTheme: user.isDarkMode ? MyThemes.darkTheme : MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          title: title,
          home: ProfilePage(),
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();


}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          appBar: buildAppBar(context),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.imagePath,
                onClicked: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MechanicEditProfilePage()),
                  );
                },
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 24),
              Center(child: buildUpgradeButton()),
              const SizedBox(height: 24),
              NumbersWidget(),
              const SizedBox(height: 48),
              buildAbout(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ).tr(),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          ).tr()
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Upgrade To PRO'.tr(),
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mechanic Experience',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              'Last Appointement',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              user.lastappointement,
              style: TextStyle(fontSize: 16, height: 1.4),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              'Last Review',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              user.lastreview,
              style: TextStyle(fontSize: 16, height: 1.4),
            ).tr(),
          ],
        ),
      );
}
