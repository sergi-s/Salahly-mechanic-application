import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoadsideAssistantFullData extends StatefulWidget {
  const RoadsideAssistantFullData({Key? key}) : super(key: key);
  static final routeName = "/roadsideassistantfulldata";
  @override
  State<RoadsideAssistantFullData> createState() => _RoadsideAssistantFullDataState();
}

class _RoadsideAssistantFullDataState extends State<RoadsideAssistantFullData> {
  List<Client> Clients = [
    Client(name: 'Ahmed tarek',
        carnumber: 'ا س ص | 4855',
        mobilenumber: "01061509239",
        carmodel: 'Kia cerato',
        color: 'red',
        image: 'assets/images/tarek.jpg',
        subscribtionlevel: 'Premium'),
  ];

  Widget personDetailCard(Client) {
    final String name = Client.name;
    final String carnumber = Client.carnumber;
    final String mobilenumber = Client.mobilenumber;
    final String carmodel = Client.carmodel;
    final String color = Client.color;
    final String image = Client.image;
    final String subscribtionlevel = Client.subscribtionlevel;
    return Container(
      alignment: Alignment.center,
          child:Column(
          children:[
            Row(
            children: <Widget>[
              Column(
          children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0,right: 8.0),
                child: Image.asset('assets/images/name.png', fit: BoxFit.fill ,scale: 2),),
              ],),
              Column(
              children: [
               Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(name, textScaleFactor: 2, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.right).tr(),),
              ],),
              ],),
            Row(

              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0,right: 8.0),
                      child: Image.asset('assets/images/car2.png', fit: BoxFit.fill ,scale: 1.5),),
                  ],),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child:Text(carnumber,textScaleFactor: 1.5, style: const TextStyle(color: Color(0xff97a7c3)),textAlign: TextAlign.right).tr(),),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child:Text(carmodel,textScaleFactor: 1.5, style: const TextStyle(color: Color(0xff97a7c3)),textAlign: TextAlign.right).tr(),),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child:Text(color,textScaleFactor: 1.5, style: const TextStyle(color: Color(0xff97a7c3)),textAlign: TextAlign.right).tr(),),
                  ],),
              ],),
            Row(
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0,right: 8.0),
                      child:
                      Image.asset('assets/images/phone.png', fit: BoxFit.fill ,scale: 2 ),),
                  ],),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child:Text(mobilenumber,textScaleFactor: 1.5, style: const TextStyle(color: Color(0xff97a7c3)),textAlign: TextAlign.right).tr(),),
                  ],),
              ],),
            Row(
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6.0,right: 8.0),
                      child:
                      Image.asset('assets/images/subscription.png', fit: BoxFit.fill ,scale: 2 ),),
                  ],),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child:Text(subscribtionlevel,textScaleFactor: 1.5, style: const TextStyle(color: Color(0xff97a7c3)),textAlign: TextAlign.right).tr(),),
                  ],),
              ],),
   ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
            'assets/images/logo white.png', fit: BoxFit.contain, scale: 50),
        centerTitle: true,
        backgroundColor: const Color(0xff193566),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/wavy shape copy.png'),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fill),
                  color: Colors.transparent
              ),
              child: Text(''),
            ),
            ListTile(
              title: const Text(
                'Home Page', style: TextStyle(fontWeight: FontWeight.bold),)
                  .tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('View Requests',
                  style: TextStyle(fontWeight: FontWeight.bold)).tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Set availability',
                  style: TextStyle(fontWeight: FontWeight.bold)).tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                  'Log Out', style: TextStyle(fontWeight: FontWeight.bold))
                  .tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              top: 35,
              left: 35,
              right: 35,
              child: const Text(
                  'RSA Full Data',textScaleFactor: 2,
                  style: TextStyle(
                      color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.center).tr(),
            ),
        Positioned(
          top:80,
          left: 35,
          right: 35,
          child: Column(
                    children:
                    Clients.map((p) {
                      return personDetailCard(p);
                    }).toList()),
             ),
            const Positioned(
              left: 50,
              right: 50,
              bottom: 320,
              child: Text(
                  'Location : Moharam Bek - Alex',textScaleFactor: 1.25,
                  style: TextStyle(
                    color: Color(0xff193566), fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
            ),
             Positioned(
              left: 150,
              right: 150,
              bottom: 220,
              child: InkWell(
                onTap: () {
                }, // Image tapped
                splashColor: Colors.blue, // Splash color over image
                child: Ink.image(
                  height: 100,
                  width: 100,
                  fit: BoxFit.contain, // Fixes border issues
                  image: AssetImage(
                      'assets/images/location.png'
                  ),
                ),
              ),

            ),
            const Positioned(
              left: 50,
              right: 50,
              bottom: 180,
              child: Text(
                  'Client Requested RSA',textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Color(0xff193566), fontWeight: FontWeight.bold,),textAlign: TextAlign.center),
            ),

            Positioned(
              right: 5.0,
              left: 6.0,
              bottom: 155,
              child: Text(
                  DateFormat.jm().format(DateTime.now()),textScaleFactor: 1.5,
                  style: const TextStyle(
                      color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.center),
            ),
            Positioned(
              bottom: 100,
                left: 80,
                right: 80,
              child: FloatingActionButton.extended(
                  onPressed: (){}, label: const Text('Report'),backgroundColor:const Color(0xff193566) , icon: const Icon(Icons.report),)
            ),
          ],
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
  final String image;
  final String subscribtionlevel;

  Client({required this.name, required this.carnumber, required this.mobilenumber, required this.carmodel, required this.color, required this.image, required this.subscribtionlevel});
}