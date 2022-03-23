import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/homepage/homescreen.dart';

class Routing {
  get router => GoRouter(

    initialLocation: HomeScreen.routeName,

    routes: <GoRoute> [
      GoRoute(
        path: HomeScreen.routeName,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
