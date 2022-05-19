import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/MechanicProfile/MechanicProfilePage.dart';
import 'package:salahly_mechanic/screens/Requests/done_requests.dart';
import 'package:salahly_mechanic/screens/Requests/done_requests_fulldata.dart';
import 'package:salahly_mechanic/screens/Requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/inActiveAccountsScreen/pendingAccounts.dart';
import 'package:salahly_mechanic/screens/profile/editProfile.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/screens/requests/allscreens.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/directionMap.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/reportscreen.dart';
import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';
import 'package:salahly_mechanic/screens/homepage/switch.dart';
import 'package:salahly_mechanic/screens/homepage/testscreen.dart';
import 'package:salahly_mechanic/screens/homepage/testscreenyoyo.dart';
import 'package:salahly_mechanic/screens/login_signup/check_login.dart';
import 'package:salahly_mechanic/screens/login_signup/registration.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:salahly_mechanic/screens/scheduler/add_scheduler_task.dart';
import 'package:salahly_mechanic/screens/scheduler/scheduler_screen.dart';
import 'package:salahly_mechanic/screens/scheduler/view_scheduler_task.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

import 'screens/switchLanguage.dart';

class Routing {
  get router => GoRouter(
        initialLocation: TestScreenAya.routeName,
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
            builder: (context, state) =>
                Registration(emailobj: state.extra! as String),
          ),
          GoRoute(
            path: CheckLogin.routeName,
            builder: (context, state) => CheckLogin(),
          ),
          GoRoute(
              path: OngoingScreenDummy.routeName,
              builder: (context, state) => OngoingScreenDummy()),
          GoRoute(
            path: PendingRequests.routeName,
            builder: (context, state) => PendingRequests(),
          ),
          GoRoute(
            path: OnGoingRequests.routeName,
            builder: (context, state) => OnGoingRequests(),
          ),
          GoRoute(
            path: RequestFullDataScreen.routeName,
            builder: (context, state) =>
                RequestFullDataScreen(rsa: state.extra! as RSA),
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
          GoRoute(
            path: ReportScreen.routeName + ":requestType&:rsaId",
            name: 'ReportScreen',
            builder: (context, state) {
              return ReportScreen(
                  rsaId: state.params["rsaId"] as String,
                  requestType: state.params["requestType"] as String);
            },
          ),
          GoRoute(
              path: Switcher.routeName,
              builder: (context, state) => Switcher()),
          GoRoute(
              path: TestScreenAya.routeName,
              builder: (context, state) => TestScreenAya()),
          GoRoute(
            path: SchedulerScreen.routeName,
            builder: (context, state) => SchedulerScreen(),
          ),
          GoRoute(
            path: ViewSchedulerTaskScreen.routeName,
            builder: (context, state) => ViewSchedulerTaskScreen(
                scheduleTaskAndFunctionOnDelete:
                    state.extra! as Map<String, dynamic>),
          ),
          GoRoute(
            path: SwitchLanguageScreen.routeName,
            builder: (context, state) => SwitchLanguageScreen(),
          ),
          GoRoute(
            path: AddSchedulerTaskScreen.routeName,
            builder: (context, state) =>
                AddSchedulerTaskScreen(onAdd: state.extra! as Function),
          ),
          GoRoute(
              path: RideLocations.routeName,
              builder: (context, state) => RideLocations(
                  bundledLocation: state.extra as BundledLocation
              )),
          GoRoute(
              path: EditProfile.routeName,
              builder: (context, state) => EditProfile()),
          GoRoute(
              path: DoneRequests.routeName,
              builder: (context, state) => DoneRequests()),
          GoRoute(
              path: DoneRequestsFullData.routeName,
              builder: (context, state) => DoneRequestsFullData()),
          GoRoute(
              path: PendingRequestsScreen.routeName,
              builder: (context, state) => PendingRequestsScreen()),
        ],
      );
}
