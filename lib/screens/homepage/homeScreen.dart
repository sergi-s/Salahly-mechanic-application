import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/firebase/requests_streaming/requests_listener.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/global_widgets/app_bar.dart';
import '../../widgets/global_widgets/app_drawer.dart';
import '../../widgets/homepage/appCard.dart';
import '../Requests/allscreens.dart';
import '../Requests/ongoing_requests.dart';
import '../Requests/pending_requests.dart';
import '../scheduler/scheduler_screen.dart';


class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomeScreen> {
  @override
  initState() {
    Future.delayed(Duration.zero, () {
      // revive();
    });
    super.initState();
  }

  bool isListening = false;

  @override
  Widget build(BuildContext context) {

    if(!isListening){
      listenRequestsFromDatabaseByNotifiers(
          ref.watch(pendingRequestsProvider.notifier),
          ref.watch(ongoingRequestsProvider.notifier));
      isListening = true;
    }

    // allCars(ref);
    //TODO: get all users data and put it in state management
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: salahlyAppBar(context),
      drawer: salahlyDrawer(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height*0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height:MediaQuery.of(context).size.height*0.02 ),
              Text(
                "welcome".tr(),
                textScaleFactor: 1.4,
                style: const TextStyle(
                  fontSize: 23,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500, color: Color(0xff193566)),
              ).tr(),
              SizedBox(height:MediaQuery.of(context).size.height*0.01 ),
              CardWidget(
                  fun: () {
                    context.push(PendingRequests.routeName);
                  },
                  title: 'Pending Requests',
                  subtitle:
                  'Display all pending requests where you can view its data and accept'
                      ' or reject each request ',
                  image: 'assets/images/clock.png',),
              SizedBox(height:MediaQuery.of(context).size.height*0.002 ),
              CardWidget(
                  fun: () {
                    context.push(OnGoingRequests.routeName);
                  },
                  title: 'Ongoing Requests',
                  subtitle:
                  'Display all requests that are in progress and view each data'
                      ' Where you can manage each request',
                  image: 'assets/images/recovery.png'),
              SizedBox(height:MediaQuery.of(context).size.height*0.002 ),
              CardWidget(
                  fun: () {
                    context.push(SchedulerScreen.routeName);
                  },
                  title: 'Time Table',
                  subtitle:
                  'Where you can schedule all your tasks and manage'
                      'also you can manage your weeks',
                  image: 'assets/images/scheduling.png'),
              // SizedBox(height:MediaQuery.of(context).size.height*0.01 ),
            ],
          ),
        ),
      ),

    );
  }

  // void revive() async {
  //   ////////////////////////
  //   ref.watch(salahlyClientProvider.notifier).getSavedData();
  //   final prefs = await SharedPreferences.getInstance();
  //
  //   if (ref.watch(salahlyClientProvider).requestType == RequestType.WSA ||
  //       ref.watch(salahlyClientProvider).requestType == RequestType.RSA ||
  //       ref.watch(salahlyClientProvider).requestType == RequestType.TTA) {
  //     ref
  //         .watch(rsaProvider.notifier)
  //         .assignRequestType(ref.watch(salahlyClientProvider).requestType!);
  //
  //     ref.watch(rsaProvider.notifier).assignRequestID(
  //         ref.watch(salahlyClientProvider).requestID.toString());
  //
  //     if (prefs.getString("mechanic") != null) {
  //       ref.watch(rsaProvider.notifier).assignMechanic(
  //           await getMechanicData(prefs.getString("mechanic")!), false);
  //     }
  //     if (prefs.getString("towProvider") != null) {
  //       ref.watch(rsaProvider.notifier).assignProvider(
  //           await getProviderData(prefs.getString("towProvider")!), false);
  //     }
  //   }
  //   ////////////////////////
  // }
}
//TODO: el translate m4 byt3ml keda, fa edit it
// and complete translation
// TODO: add photo to TTA line:55
// Use state management to get user data
