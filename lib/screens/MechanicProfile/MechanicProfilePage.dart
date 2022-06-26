import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/MechanicProfile/MechanicEditProfilePage.dart';
import 'package:salahly_mechanic/utils/get_mechanic_provider_data.dart';
import 'package:salahly_mechanic/widget/numbers_widget.dart';
import 'package:salahly_mechanic/widget/profile_widget.dart';
import 'package:salahly_mechanic/themes.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_drawer.dart';
import 'package:salahly_models/models/mechanic.dart';

import '../profile/editProfile.dart';

class MechanicProfilePage extends StatelessWidget {
  static final String title = 'User Profile';
  static final routeName = "/profile_page";
  @override
  Widget build(BuildContext context) {

    return ThemeProvider(
      initTheme: MyThemes.lightTheme,
      child: Builder(
        builder: (context) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: Theme.of(context),
          title: title,
          home: _ProfilePage(),
        ),
      ),
    );
  }
}

class _ProfilePage extends StatefulWidget {
  const _ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();


}

class _ProfilePageState extends State<_ProfilePage> {

  dynamic user = Mechanic(name: "", email: "",phoneNumber: "");

  @override
  initState() {
    getMechanicOrProviderData(FirebaseAuth.instance.currentUser!.uid).then((value) => setState(() {
      user = value;
    }));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFFd1d9e6),
          appBar: salahlyAppBar(context,title:   'profile'.tr()),
          drawer: salahlyDrawer(context),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              ProfileWidget(
                imagePath: user.avatar !=null?user.avatar!: 'https://aui.atlassian.com/aui/8.8/docs/avatars.html',
                onClicked: () {
                  context.push(EditProfile.routeName, extra: user);
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(builder: (context) => EditProfile(user:user)),
                  // );
                },
              ),
              const SizedBox(height: 24),
              buildName(user),
              const SizedBox(height: 24),
              NumbersWidget(rating: user.rating.toString(),),
              const SizedBox(height: 48),
              buildAbout(user),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildName(user) => Column(
        children: [
          Text(
            user.name!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: Color(0xff193566)),
          ).tr(),
          const SizedBox(height: 4),
          Text(
            user.email!,
            style: TextStyle(color: Colors.black54,fontSize: 15),
          ).tr(),
          const SizedBox(height: 4),
          Text(
            user.phoneNumber!=null?user.phoneNumber.toString():"",
            style: TextStyle(color: Colors.black54,fontSize: 15),
          ).tr()
        ],
      );

  Widget buildAbout(user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'location'.tr(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Color(0xff193566)),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              user.loc!=null?user.loc!.address!:"",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text(
              'workshop_name'.tr(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Color(0xff193566)),
            ).tr(),
            const SizedBox(height: 16),
            Text(
              user.loc!=null?user.loc!.name!:"",
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            // const SizedBox(height: 16),
            // Text(
            //   'Last Appointement',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Color(0xff193566)),
            // ).tr(),
            // const SizedBox(height: 16),
            // Text(
            //   user.lastappointement,
            //   style: TextStyle(fontSize: 16, height: 1.4),
            // ).tr(),
            const SizedBox(height: 16),
            // Text(
            //   'Last Review',
            //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Color(0xff193566)),
            // ).tr(),
            // const SizedBox(height: 16),
            // Text(
            //   user.lastreview,
            //   style: TextStyle(fontSize: 16, height: 1.4),
            // ).tr(),
          ],
        ),
      );
}
