import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/firebase/requests_streaming/requests_listener.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/classes/scheduler/scheduler.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:salahly_mechanic/screens/Requests/ongoing_requests.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';
import 'package:salahly_mechanic/screens/homepage/switch.dart';
import 'package:salahly_mechanic/screens/homepage/testscreen.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:salahly_mechanic/screens/scheduler/add_scheduler_task.dart';
import 'package:salahly_mechanic/screens/scheduler/scheduler_screen.dart';
import 'package:salahly_mechanic/screens/test_foula.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_drawer.dart';
import 'package:salahly_models/models/car.dart';
import 'package:salahly_models/models/location.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

import '../../main.dart';

class OngoingScreenDummy extends ConsumerWidget {
  static final routeName = "/ongoingscreendummy";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PendingRequestsNotifier pendingNotifier =
        ref.watch(pendingRequestsProvider.notifier);
    OngoingRequestsNotifier ongoingRequestsNotifier =
        ref.watch(ongoingRequestsProvider.notifier);
    List<RSA> ongoingRequests = ref.watch(ongoingRequestsProvider);
    return Scaffold(
      appBar: salahlyAppBar(),
      drawer: salahlyDrawer(context),
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        // pendingNotifier.startRequestsListener();
                        listenRequestsFromDatabaseByNotifiers(
                            pendingNotifier, ongoingRequestsNotifier);
                      },
                      child: Text("Start stream")),
                  Text("Number of pending requests found " +
                      ref.watch(pendingRequestsProvider).length.toString()),
                  Text("Number of ongoing requests found " +
                      ref.watch(ongoingRequestsProvider).length.toString()),
                  ElevatedButton(
                      onPressed: () {
                        // context.go(TestScreenFoula.routeName);
                        context.push(ONGOINGVIEW.routeName);
                      },
                      child: Text('go to ongoing screen')),
                  ElevatedButton(
                      onPressed: () {
                        // context.go(TestScreenFoula.routeName);
                        // context.push(PENDINGVIEW.routeName);
                        context.push(PendingRequests.routeName);
                      },
                      child: Text('go to pending screen')),
                  ElevatedButton(
                      onPressed: () {
                        // context.go(TestScreenFoula.routeName);
                        // contex//t.push(PENDINGVIEW.routeName);
                        context.push(Switcher.routeName);
                      },
                      child: Text('Set availability')),
                  ElevatedButton(
                      onPressed: () {
                        context.goNamed("ReportScreen", params: {
                          "requestType": "wsa",
                          "rsaId": "12345678"
                        });
                      },
                      child: Text("Write report screen")),
                  ElevatedButton(
                    onPressed: () {
                      context.push(SchedulerScreen.routeName);
                    },
                    child: Text("Scheduler screen"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.push(OnGoingRequests.routeName);
                    },
                    child: Text("Ongoing UI screen"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.push(AddSchedulerTaskScreen.routeName);
                      },
                      child: Text("AddSchedulerTaskScreen screen"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
dynamic v = await Scheduler.getTasks();
for(ScheduleTask i in v){
  print(i.startDate.toString()+" "+i.id.toString());
}
                    },
                    child: Text("All data in scheduler"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      List<ScheduleTask>? v = await Scheduler.getTasks();
                      while(v!.isNotEmpty){
                        Scheduler.deleteTask(v.first);
                      }
                    },
                    child: Text("Erase all data in scheduler in db"),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        await dbRef.child("FCMTokens").child(FirebaseAuth.instance.currentUser!.uid).remove();
                        await FirebaseAuth.instance.signOut();
                        context.go(LoginSignupScreen.routeName);
                      },
                      child: Text("Log out"))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PENDINGVIEW extends ConsumerWidget {
  static final routeName = "/pendingviewongoingviewawdawdawdawd";

  const PENDINGVIEW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PendingRequestsNotifier pendingNotifier =
        ref.watch(pendingRequestsProvider.notifier);
    List<RSA> pendingRequests = ref.watch(pendingRequestsProvider);
    // print("Length of list "+pendingRequests.length.toString());
    // print("latitude "+pendingRequests[0].location!.latitude.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Pending requests"),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: pendingRequests.length,
            itemBuilder: (context, index) {
              // print((pendingRequests[index]).state);
              // print((pendingRequests[index]).requestType);
              // print(RSA.typeToString(pendingRequests[index].requestType!));
              return ListTile(
                leading: const Icon(Icons.directions_car),
                title: Text(RSA
                    .requestTypeToString(pendingRequests[index].requestType!)),
                //Text('ID: '+pendingRequests[index].rsaID!),
                subtitle: Text('ID: ' + pendingRequests[index].rsaID!),
                //Text(pendingRequests[index].state.toString()),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          pendingNotifier.acceptRequest(pendingRequests[index]);
                        },
                        icon: const Icon(Icons.check_circle),
                      ),
                      IconButton(
                        onPressed: () {
                          pendingNotifier.denyRequest(pendingRequests[index]);
                        },
                        icon: const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 30,
                          child: Icon(Icons.close),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class ONGOINGVIEW extends ConsumerWidget {
  static final routeName = "/ongoingviewawdawdawdawd";

  const ONGOINGVIEW({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    OngoingRequestsNotifier pendingNotifier =
        ref.watch(ongoingRequestsProvider.notifier);
    List<RSA> ongoingRequests = ref.watch(ongoingRequestsProvider);
    // print("Length of list "+ongoingRequests.length.toString());
    // print("latitude "+ongoingRequests[0].location!.latitude.toString());
    return Scaffold(
      appBar: AppBar(
        title: Text("Ongoing requests"),
      ),
      body: SafeArea(
        child: ListView.builder(
            itemCount: ongoingRequests.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  // open rsa screen
                  // Navigator.pushNamed(context, RSAVIEW.routeName,
                  //     arguments: ongoingRequests[index]);
                },
                leading: Icon(Icons.directions_car),
                title: Text(RSA
                    .requestTypeToString(ongoingRequests[index].requestType!)
                    .tr()),
                //Text('ID: '+ongoingRequests[index].rsaID!),
                subtitle: Text(ongoingRequests[index].state.toString()),
                trailing: Container(
                  width: 100,
                  child: Row(
                    children: [],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
