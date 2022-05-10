import 'dart:convert';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/RoadsideAssistantFullData.dart';
import 'package:salahly_models/models/road_side_assistance.dart';


class OnGoingRequests extends ConsumerStatefulWidget {
  const OnGoingRequests({Key? key,}) : super(key: key);
  static final routeName = "/ongoingrequests";
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
    final String color=rsa.car!.color!;
    print("requestType: $requestType");
    print("carNumber: $carNumber");
    print("carModel: $carModel");
    print("color: $color");
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
                  leading:Icon(CupertinoIcons.car_detailed,color:Color(int.parse(color)),size: 40),
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
  Widget build(BuildContext context) {

    _requests = ref.watch(ongoingRequestsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: AppBar(
        title: Text('Ongoing Requests'),
        centerTitle: true,
        backgroundColor: const Color(0xff193566),
        flexibleSpace: Image.asset('assets/images/logo white.png',fit: BoxFit.scaleDown,alignment: Alignment.bottomRight,scale: 55),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/wavy shape copy.png'),alignment: Alignment.topCenter,fit: BoxFit.fill),
                  color: Colors.transparent
              ),
              child: Text(''),
            ),
            ListTile(
              title: const Text('Home Page',style: TextStyle(fontWeight: FontWeight.bold),).tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('View Requests',style: TextStyle(fontWeight: FontWeight.bold)).tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Set availability',style: TextStyle(fontWeight: FontWeight.bold)).tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      body: Center(
        child:Column(
          children: _requests.map((request) => rsaDetailsCard(request)).toList(),
            // children:
            // Clients.map((p) {
            //   return personDetailCard(p);
            // }).toList()
        ),
      ),
    );
  }
}
