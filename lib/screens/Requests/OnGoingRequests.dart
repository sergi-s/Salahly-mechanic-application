import 'dart:convert';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class OnGoingRequests extends StatefulWidget {
  const OnGoingRequests({Key? key,}) : super(key: key);
  static final routeName = "/ongoingrequests";
  @override
  _ClientsDataState createState() => _ClientsDataState();
}

class _ClientsDataState extends State<OnGoingRequests> {

  List<Client> Clients = [
    Client(name: 'Ahmed tarek', carnumber: 'ا س ص | 4855', mobilenumber: "01061509239" , carmodel: 'Kia cerato', color:'red'),
    Client(name: 'mohamed tarek', carnumber: 'ا م ص | 9875', mobilenumber: "01033633594" , carmodel: 'mini cooper',color:'black'),
    Client(name: 'Ziad tarek', carnumber: 'ا ع ص | 8975', mobilenumber: "01205167061" , carmodel: 'Renault Logon',color:'white')
  ];
  Widget personDetailCard(Client) {
    final String name=Client.name;
    final String carnumber=Client.carnumber;
    final String carmodel=Client.carmodel;
    final String color=Client.color;
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
              debugPrint('Card tapped.');
            },
            child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading:Icon(CupertinoIcons.car_detailed,color:Color(0xff97a7c3),size: 40),
                  title: Text(name , textScaleFactor: 1.4,style: TextStyle(color: Color(0xff193566),fontWeight:FontWeight.bold)).tr(),
                  subtitle: Text(carnumber ,textScaleFactor: 1.1, style: TextStyle(color:Colors.black54 )).tr(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: AppBar(
        title: Text('OnGoing Requests'),
        centerTitle: true,
        backgroundColor: Color(0xff193566),
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
            children:
            Clients.map((p) {
              return personDetailCard(p);
            }).toList()
        ),
      ),
    );
  }
}

class Client {
  final String name;
  final String carnumber;
  final String mobilenumber;
  final String carmodel;
  final String color;

  Client({required this.name, required this.carnumber, required this.mobilenumber, required this.carmodel, required this.color});
}