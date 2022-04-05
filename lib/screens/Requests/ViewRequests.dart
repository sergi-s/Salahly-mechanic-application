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
      height: 150,
      alignment: Alignment.center,
      child: Card(
        margin:const EdgeInsets.all(16.0),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(Client.name,
                        style: TextStyle (
                            color: Color(0xff193566),
                            fontSize: 18
                        ),
                      ),
                      Text(Client.carnumber,
                        style: TextStyle (
                            color: Color(0xff97a7c3),
                            fontSize: 12
                        ),
                      ),
                      Text(Client.mobilenumber,
                        style: TextStyle (
                            color: Color(0xff97a7c3),
                            fontSize: 12
                        ),
                      ),
                      Text(Client.carmodel,
                        style: TextStyle (
                            color: Color(0xff97a7c3),
                            fontSize: 12
                        ),
                      )

                      ],
                    ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Container(
                    alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(left: 10.0,bottom:10.0),
                  child:Row(
                  children: <Widget>[
                  FloatingActionButton.small(
                    backgroundColor: Colors.greenAccent[700],
                    elevation: 3.0,
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
                    child: Icon(
                      Icons.check,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                  FloatingActionButton.small(
                    backgroundColor: Colors.red,
                    elevation: 3.0,
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
                    child: Icon(
                      Icons.close,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
                  ),
        ],
              ),
            ],
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
          ],
        ),
      ),

      body: Center(
        child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
  final String problem;

  Client({required this.name, required this.carnumber, required this.mobilenumber, required this.carmodel, required this.problem});
}

