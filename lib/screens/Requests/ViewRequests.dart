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


class ViewRequests extends StatefulWidget {
  const ViewRequests({Key? key,}) : super(key: key);
  static final routeName = "/viewrequests";
  @override
  _ClientsDataState createState() => _ClientsDataState();
}

class _ClientsDataState extends State<ViewRequests> {

  List<Client> Clients = [
    Client(name: 'Ahmed tarek', carnumber: 'ا س ص | 4855', mobilenumber: "01061509239" , carmodel: 'Kia cerato', problem:'Car is Broken'),
    Client(name: 'mohamed tarek', carnumber: 'ا م ص | 9875', mobilenumber: "01033633594" , carmodel: 'mini cooper',problem:'car is notworking proberly'),
    Client(name: 'Ziad tarek', carnumber: 'ا ع ص | 8975', mobilenumber: "01205167061" , carmodel: 'Renault Logon',problem:'i have many problems')
  ];
  Widget personDetailCard(Client) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.grey[100],
        semanticContainer: true,
        margin:const EdgeInsets.symmetric(vertical:10,horizontal:25 ),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: ()
            async {
              if (await confirm(
              context,
              title: const Text('Confirm').tr(),
            content: const Text('Car is Broken').tr(),
            textOK: const Text('Yes').tr(),
            textCancel: const Text('No').tr(),
            )) {
            return print('pressedOK');
            }
            return print('pressedCancel');

          },
          child:
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                        title: Column(
                         children: <Widget>[
                           Text(Client.carmodel,
                             style: const TextStyle (
                                 color: Color(0xff193566),
                                 fontSize: 20 ,
                                 fontWeight: FontWeight.bold
                          ),
                           ),
                           Text(Client.carnumber,
                             style: const TextStyle (
                                 color: Colors.black45,
                                 fontSize: 18
                             ),
                           ),
                           Text(Client.mobilenumber,
                             style: const TextStyle(
                                 color: Colors.black45,
                                 fontSize: 18
                             ),
                           ),
                         ],
                        ),
                        trailing : Row(
                          mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconButton(
                                onPressed: () async {
                                  if (await confirm(
                                    context,
                                    title: const Text('Confirm').tr(),
                                    content: const Text('Would you like to Accept Request?').tr(),
                                    textOK: const Text('Yes').tr(),
                                    textCancel: const Text('No').tr(),
                                  )) {
                                    return print('pressedOK');
                                  }
                                  return print('pressedCancel');
                                },
                                icon: const Icon(
                                  Icons.check,
                                  size: 35,
                                  color: Colors.green,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  if (await confirm(
                                    context,
                                    title: const Text('Confirm').tr(),
                                    content: const Text('Would you like to Refuse Request?').tr(),
                                    textOK: const Text('Yes').tr(),
                                    textCancel: const Text('No').tr(),
                                  )) {
                                    return print('pressedOK');
                                  }
                                  return print('pressedCancel');
                                },
                                icon: const Icon(
                                  Icons.close,
                                  size: 35,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        ),
    ],
                      ),

              ),
    ),
    ),
    );
  }
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Color(0xFFd1d9e6),
      appBar: AppBar(
        title:Text('View Requests'),
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
              title: const Text('OnGoing Requests',style: TextStyle(fontWeight: FontWeight.bold)).tr(),
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

      body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          children:
          Clients.map((p) {
              return personDetailCard(p);
            }).toList()
        ),
      );
  }
}
class Client {
  final String name;
  final String carnumber;
  final String mobilenumber;
  final String carmodel;
  final String problem;

  Client({required this.name, required this.carnumber, required this.mobilenumber, required this.carmodel, required this.problem});
}

