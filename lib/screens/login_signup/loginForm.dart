import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/firebase/requests_streaming/requests_listener.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/screens/Requests/allscreens.dart';
import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_mechanic/widgets/login_signup/Rounded_Bottom.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salahly_models/util/validation.dart' as Validator;
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/widgets/login_signup/Rounded_password.dart';
import 'package:salahly_mechanic/widgets/login_signup/roundedInput.dart';
import 'package:salahly_mechanic/classes/firebase/firebase.dart';

class LoginForm extends  ConsumerStatefulWidget {
  var size;

  var defaultlogin;

  LoginForm({
    Key? key,
    required this.size,
    required this.defaultlogin,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginFormState();
  }

}
class _LoginFormState extends ConsumerState<LoginForm> {
  late final Size size;
  late final double defaultlogin;
  String email = "";
  String password = "";
  FirebaseCustom fb = FirebaseCustom();

  @override
  initState() {
    super.initState();
    size = widget.size;
    defaultlogin = widget.defaultlogin;
  }

  updateEmail(String e) {
    email = e;
  }

  updatePassword(String pass) {
    password = pass;
  }

  loginFunction(BuildContext context, WidgetRef ref) async {
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
      listenRequestsFromDatabaseByNotifiers(
          ref.watch(pendingRequestsProvider.notifier),
          ref.watch(ongoingRequestsProvider.notifier));
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login successful')));
      context.go(HomeScreen.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account isnt Correct !!Please try again')));
    }
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
          // Text(
          //   "welcome_back".tr(),
          //
          //   style: GoogleFonts.raleway(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 24,
          //   ),
          // ),
          Image.asset(
            'assets/images/logo ta5arog colored car.png',
            width: 300,
          ),
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
          SizedBox(
            width: size.width * 0.4,
            height: 40,
            child: RaisedButton(
              color: Color(0xFF193566),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                loginFunction(context, ref);
              },
              child: Text(
                "Login".tr(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
