import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/screens/Requests/OnGoingRequests.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';
import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:salahly_mechanic/screens/requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';

class CheckLogin extends ConsumerWidget {
  const CheckLogin({Key? key}) : super(key: key);
  static const routeName = "/checklogin";

  _startChecking(BuildContext context,WidgetRef ref) async {
    PendingRequestsNotifier pendingNotifier = ref.watch(pendingRequestsProvider.notifier);
    if ((await FirebaseAuth.instance.currentUser) == null) {
      context.go(LoginSignupScreen.routeName);
    } else {
      // pendingNotifier.listenRequestsFromDatabase();
      context.go(RoadsideAssistantFullData.routeName);
      // context.go(OngoingScreenDummy.routeName);
    }
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    _startChecking(context,ref);
    return const Scaffold(body: SafeArea(child: Text("Checking logged in user error")));
  }
}
