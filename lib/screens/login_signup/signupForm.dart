import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/widgets/login_signup/Rounded_Bottom.dart';
import 'package:salahly_mechanic/widgets/login_signup/Rounded_password.dart';
import 'package:salahly_mechanic/widgets/login_signup/roundedInput.dart';
import 'package:easy_localization/easy_localization.dart';

// import 'package:slahly/utils/validation.dart';
import 'package:salahly_models/util/validation.dart' as Validation;
import 'package:salahly_mechanic/classes/firebase/firebase.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({
    Key? key,
    required this.defaultlogin,
  }) : super(key: key);

  final double defaultlogin;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Validator validation = Validator();
  FirebaseCustom fb = FirebaseCustom();

  //late TextEditingController emailController = TextEditingController();
  String email = "";

  String password = "";

  String confirmpassword = "";

  updateEmail(String e) {
    email = e;
  }

  updatepassword(String pass) {
    password = pass;
  }

  updateconfirmpassword(String confpass) {
    confirmpassword = confpass;
  }

  signupFunction(BuildContext context) async {
    // if (!Validation.Validator.emailValidator(email)) {
    //   return ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content: Text('Invalid Email!! Please try again')));
    // }
    // if (!Validation.Validator.passValidator(password)) {
    //   return ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content: Text('Invalid Password!! Please try again')));
    // }
    if (confirmpassword != password) {
      return ScaffoldMessenger.of(context).showSnackBar( SnackBar(
          content: Text('password_doesnt_match'.tr())));
    }
    bool check = await fb.signup(email, password);
    if (check) {
      ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('account_created'.tr())));
    } else {
      return ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('email_used'.tr())));
    }
    context.go(Registration.routeName, extra: email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.defaultlogin,
      //color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text(
          //   'Welcome Back',
          //   style:TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 24,
          //   ),
          // ),
          SizedBox(height: 40),
          Image.asset(
            'assets/images/logo ta5arog 2.png',
            width: 300,
          ),
          //SvgPicture.assets('assets/images/icon.svg'),
          SizedBox(height: 40),
          // RounedInput(
          //   icon: Icons.face,
          //   hint: 'username'.tr(),
          //   fn: updateUsername,
          // ),
          RounedInput(
            icon: Icons.email,
            hint: 'email'.tr(),
            fn: updateEmail,
          ),
          RounedPasswordInput(
            hint: 'password'.tr(),
            function: updatepassword,
          ),
          RounedPasswordInput(
            hint: 'confirm_password'.tr(),
            function: updateconfirmpassword,
          ),
          //RounedInput(icon: Icons.phone, hint: 'phone_number'.tr(), fn:updatePhonenumber,),
          SizedBox(height: 10),
          SizedBox(
            width: size.width * 0.4,
            height: 40,
            child: RaisedButton(
              color: Colors.grey[200],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              onPressed: () {
                signupFunction(context);
              },
              child: Text(
                "signup".tr(),
                style: TextStyle(color: Color(0xFF193566)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
