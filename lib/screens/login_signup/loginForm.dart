import 'package:flutter/material.dart';
import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';
import 'package:salahly_mechanic/widgets/login_signup/Rounded_Bottom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salahly_models/util/validation.dart' as Validator;
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/widgets/login_signup/Rounded_password.dart';
import 'package:salahly_mechanic/widgets/login_signup/roundedInput.dart';
import 'package:salahly_mechanic/classes/firebase/firebase.dart';

class LoginForm extends StatelessWidget {



  LoginForm({
    Key? key,
    required this.size,
    required this.defaultlogin,
  }) : super(key: key);

  final Size size;
  final double defaultlogin;
  String email = "";
  String password = "";
  FirebaseCustom fb = FirebaseCustom();

  updateEmail(String e) {
    email = e;
  }

  updatePassword(String pass) {
    password = pass;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: defaultlogin,
      //color: Color(0xFFd1d9e6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "welcome_back".tr(),
            // style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 24,
            //
            style: GoogleFonts.raleway(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 40),
          Image.asset(
            'assets/images/logo ta5arog coloredsalahli.png',
            width: 300,
          ),
          //SvgPicture.assets('assets/images/icon.svg'),
          SizedBox(height: 40),

          RounedInput(
            icon: Icons.email,
            hint: 'Email'.tr(),
            fn: updateEmail,
          ),
          RounedPasswordInput(hint: 'password'.tr(), function: updatePassword),
          SizedBox(height: 10),
          RoundedButton(
            title: 'login'.tr(),
            onPressedFunction: () async {
              // if (!Validator.emailValidator(email)) {
              //   return ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //           content: Text('Invalid Email!! Please try again')));
              // }
              // if (!Validator.passValidator(password)) {
              //   return ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(
              //           content: Text('Invalid Password!! Please try again')));
              // }
              bool check = await fb.login(email, password);
              if (check) {

                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                        'Login successful')));
                context.go(TestScreenFoula.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(
                        'Account isnt Correct !!Please try again')));
                };

              },

          )
        ],
      ),
    );
  }
}
