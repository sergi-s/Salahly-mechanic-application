import 'dart:convert';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/homepage/homescreen.dart';


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
      height: 200,
      alignment: Alignment.center,
      child: Center(
        child:Card(
          margin:const EdgeInsets.all(16.0),
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
                  minLeadingWidth: 100,
                  horizontalTitleGap: 25,
                  leading: Text(name , textScaleFactor: 1.5,style: TextStyle(color: Color(0xff193566),fontWeight:FontWeight.bold)).tr(),
                  title: Text(carnumber , style: TextStyle(color:Color(0xff97a7c3) )).tr(),
                  subtitle: Text(carmodel , style: TextStyle(color:Color(0xff97a7c3) )).tr(),
                  trailing: Text(color , style: TextStyle(color:Color(0xff97a7c3) )).tr(),
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
      appBar: AppBar(
        title: Image.asset('assets/images/logo white.png', fit: BoxFit.contain, scale:50),
        centerTitle: true,
        backgroundColor: Color(0xff193566),
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
            ListTile(
              title: const Text('Log Out',style: TextStyle(fontWeight: FontWeight.bold)).tr(),
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