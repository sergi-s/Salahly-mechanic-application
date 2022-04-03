import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/MechanicProfile/MechanicProfilePage.dart';
import 'package:salahly_mechanic/screens/Requests/OnGoingRequests.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';
import 'package:salahly_mechanic/screens/homepage/homescreen.dart';
import 'package:salahly_mechanic/screens/Requests/ViewRequests.dart';
import 'package:salahly_mechanic/screens/MechanicProfile/MechanicProfilePage.dart';
class Routing {
  get router => GoRouter(

    initialLocation: MechanicProfilePage.routeName,

    routes: <GoRoute> [
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
    ],
  );
}
