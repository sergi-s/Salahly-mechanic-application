import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/homepage/homescreen.dart';
import 'package:salahly_mechanic/screens/homepage/testscreen.dart';

class Routing {
  get router => GoRouter(

    initialLocation: SetAvalability.routeName,

    routes: <GoRoute> [
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: SetAvalability.routeName,
        builder: (context, state) => SetAvalability(),
      ),
    ],
  );
}
