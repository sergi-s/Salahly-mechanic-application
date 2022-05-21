import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_drawer.dart';
import 'package:salahly_models/models/road_side_assistance.dart';


class OnGoingRequests extends ConsumerStatefulWidget {
  const OnGoingRequests({Key? key,}) : super(key: key);
  static const routeName = "/ongoingRequests";

  Widget build(BuildContext context, WidgetRef ref) {
    // PendingRequestsNotifier pendingNotifier =
    //     ref.watch(pendingRequestsProvider.notifier);
    // OngoingRequestsNotifier ongoingRequestsNotifier =
    //     ref.watch(ongoingRequestsProvider.notifier);
    // List<RSA> ongoingRequests = ref.watch(ongoingRequestsProvider);
    return Scaffold(
      appBar: salahlyAppBar(context,title:  "ongoing_requests".tr()),
      // drawer: salahlyDrawer(context),
      /*body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              // height: 500,
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
                        FirebaseAuth.instance.signOut();
                        context.go(LoginSignupScreen.routeName);
                      },
                      child: Text("Log out"))
                ],
              ),
            ),
          ],
        ),
      ),*/
    );
  }

  @override
  _ClientsDataState createState() => _ClientsDataState();

}

class _ClientsDataState extends ConsumerState<OnGoingRequests> {

  List<RSA> _requests = [];
  @override
  void initState() {

    super.initState();
  }
  
  Widget rsaDetailsCard(RSA rsa) {
    final String requestType = RSA.requestTypeToString(rsa.requestType!);
    final String carNumber=rsa.car!.noPlate;
    final String carModel=rsa.car!.model!;
    final Color color=rsa.car != null ?rsa.car!.color! :Colors.lightBlueAccent;
    // print("requestType: $requestType");
    // print("carNumber: $carNumber");
    // print("carModel: $carModel");
    // print("color: $color");
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Center(
        child:Card(
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin:const EdgeInsets.symmetric(vertical:6,horizontal:25 ),
          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              context.push(RequestFullDataScreen.routeName,extra: rsa);
            },
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading:Icon(CupertinoIcons.car_detailed,color:color,size: 40),
                  title: Center(child: Text(carModel , textScaleFactor: 1.4,style: const TextStyle(color: Color(0xff193566),fontWeight:FontWeight.bold)),),
                  subtitle:Padding(
                    padding: const EdgeInsets.only(top:5),
                    child: Center(child:  Text(carNumber ,textScaleFactor: 1.2, style: const TextStyle(color:Colors.black54 )),)
                  ),
                  trailing: Text(requestType ,textScaleFactor: 1.4, style: const TextStyle(color:Colors.black87 )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    _requests = ref.watch(ongoingRequestsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: salahlyAppBar(context, title: "ongoing_requests".tr()),

      // drawer: salahlyDrawer(context),

      body: Center(
        child:SingleChildScrollView(
          child: Column(
            children: _requests.map((request) => rsaDetailsCard(request)).toList(),
              // children:
              // Clients.map((p) {
              //   return personDetailCard(p);
              // }).toList()
          ),
        ),
      ),
    );
  }
}
