import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/screens/homepage/switch.dart';
import 'package:salahly_mechanic/screens/testscreens/testscreen.dart';

import '../../widgets/homepage/app_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final routeName = "/homescreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:ElevatedButton(
        onPressed: (){
          context.go(Switcher.routeName);
        }, child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "welcome",
            textScaleFactor: 1.4,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Color(0xff193566)),
          ),
          CardWidget(
              fun: () {
                context.push(PendingRequests.routeName);
              },
              title: 'Pending Requests',
              subtitle:
              'Go to the pending requests screen to see all the requests that are waiting for you to accept or reject.',
              image: 'assets/images/tow-truck 2.png'),
          CardWidget(
              fun: () {
                context.push(PendingRequests.routeName);
              },
              title: 'Ongoing Requests',
              subtitle:
              'Go to the ongoing requests screen to see all the requests that are currently being serviced.',
              image: 'assets/images/tow-truck 2.png'),
          CardWidget(
              fun: () {
                context.push(PendingRequests.routeName);
              },
              title: 'Scheduler',
              subtitle:
              'Go to the scheduler screen to see all the tasks you have scheduled.',
              image: 'assets/images/tow-truck 2.png')
          ,
        ],
      ),
      )));

  }
}
