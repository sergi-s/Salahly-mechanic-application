import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/MechanicProfile/MechanicProfilePage.dart';
import 'package:salahly_mechanic/screens/Requests/OnGoingRequests.dart';
import 'package:salahly_mechanic/screens/Requests/ViewRequests.dart';
import 'package:salahly_mechanic/screens/Requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';
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
          GoRoute(
            path: OngoingScreenDummy.routeName,
            builder: (context,state) => OngoingScreenDummy()
          ),
          GoRoute(
            path: HomeScreen.routeName,
            builder: (context, state) => HomeScreen(),
          ),
          GoRoute(
            path: ViewRequests.routeName,
            builder: (context, state) => ViewRequests(),
          ),
          GoRoute(
            path: OnGoingRequests.routeName,
            builder: (context, state) => OnGoingRequests(),
          ),
          GoRoute(
            path: RoadsideAssistantFullData.routeName,
            builder: (context, state) => RoadsideAssistantFullData(),
          ),
          GoRoute(
            path: MechanicProfilePage.routeName,
            builder: (context, state) => MechanicProfilePage(),
          ),
          GoRoute(
            path: ONGOINGVIEW.routeName,
            builder: (context, state) => ONGOINGVIEW(),
          ),
          GoRoute(
            path: PENDINGVIEW.routeName,
            builder: (context, state) => PENDINGVIEW(),
          ),
        ],
      );
}
