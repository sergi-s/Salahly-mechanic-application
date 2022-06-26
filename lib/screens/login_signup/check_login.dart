import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';

import 'package:salahly_mechanic/screens/Requests/ongoing_requests.dart';

import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';

import 'package:salahly_mechanic/screens/homepage/homeScreen.dart';

import 'package:salahly_mechanic/screens/homepage/switch.dart';

import 'package:salahly_mechanic/screens/homepage/testscreenyoyo.dart';

import 'package:salahly_mechanic/screens/inActiveAccountsScreen/banned_accounts.dart';

import 'package:salahly_mechanic/screens/inActiveAccountsScreen/pending_accounts.dart';

import 'package:salahly_mechanic/screens/inActiveAccountsScreen/rejected_accounts.dart';

import 'package:salahly_mechanic/screens/login_signup/registration.dart';

import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';

import 'package:salahly_mechanic/screens/requests/allscreens.dart';

import 'package:salahly_mechanic/screens/test_foula.dart';


import '../../utils/check_user_account_state.dart';


class CheckLogin extends ConsumerWidget {

  const CheckLogin({Key? key}) : super(key: key);
  static const routeName = "/checklogin";

  _startChecking(BuildContext context,WidgetRef ref) async {

    PendingRequestsNotifier pendingNotifier = ref.watch(pendingRequestsProvider.notifier);
    if ((await FirebaseAuth.instance.currentUser) == null) {

      context.go(LoginSignupScreen.routeName);
    } else {
      AccountStates state = await getAccountState();
      if(state == AccountStates.NO_DATA){
        context.go(Registration.routeName,extra: FirebaseAuth.instance.currentUser!.email!);
      }
      else if(state == AccountStates.PENDING) {
        context.go(PendingAccountsScreen.routeName);
      }
      else if(state == AccountStates.BANNED){
        context.go(BannedAccountsScreen.routeName);
      }
      else if(state == AccountStates.REJECTED){
        context.go(RejectedAccountsScreen.routeName);
      }
      else{
        print('account state is ${state}');
        context.go(HomeScreen.routeName);

      }
      // else if(state == AccountStates.INACTIVE) {
      //   context.go(InActiveAccountsScreen.routeName);
      // }

    }
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    _startChecking(context,ref);
    return  Scaffold(body: SafeArea(child: Text('checking_logged_in_user'.tr())));

  }
}
