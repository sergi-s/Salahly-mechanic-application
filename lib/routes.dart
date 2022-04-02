import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';
import 'package:salahly_mechanic/screens/homepage/testscreen.dart';
import 'package:salahly_mechanic/screens/login_signup/check_login.dart';
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';

class Routing {
  get router => GoRouter(
        initialLocation: CheckLogin.routeName,
        routes: <GoRoute>[
          GoRoute(
            path: HomeScreen.routeName,
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: SetAvalability.routeName,
            builder: (context, state) => SetAvalability(),
          ),
          GoRoute(
            path: TestScreenFoula.routeName,
            builder: (context, state) => TestScreenFoula(),
          ),
          GoRoute(
            path: LoginSignupScreen.routeName,
            builder: (context, state) => LoginSignupScreen(),
          ),
          GoRoute(
            path: Registration.routeName,
            builder: (context, state) => Registration(emailobj: state.extra! as String),
          ),
          GoRoute(
            path: CheckLogin.routeName,
            builder: (context, state) => CheckLogin(),
          ),
        ],
      );
}
