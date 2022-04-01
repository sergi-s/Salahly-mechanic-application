import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

      height: 300,
      width: 600,
      alignment: Alignment.center,
      child: Center(
          child:
          Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
              child:Text(name, textScaleFactor: 2.5,
                  style: TextStyle(
                      color: Color(0xff193566), fontWeight: FontWeight.bold))
                  .tr(),
              ),
          Padding(
          padding: EdgeInsets.all(3.0),
          child:Text(carnumber,textScaleFactor: 1.5, style: TextStyle(color: Color(0xff97a7c3))).tr(),),
          Padding(
          padding: EdgeInsets.all(3.0),
          child:Text(carmodel,textScaleFactor: 1.5, style: TextStyle(color: Color(0xff97a7c3))).tr(),),
          Padding(
          padding: EdgeInsets.all(3.0),
          child:Text(color,textScaleFactor: 1.5, style: TextStyle(color: Color(0xff97a7c3))).tr(),),
          Padding(
          padding: EdgeInsets.all(3.0),
          child:Text(mobilenumber,textScaleFactor: 1.5, style: TextStyle(color: Color(0xff97a7c3)))
                  .tr(),),
          Padding(
          padding: EdgeInsets.all(3.0),
          child:Text(
                  subscribtionlevel,textScaleFactor: 1.5, style: TextStyle(color: Color(0xff97a7c3)))
                  .tr(),),

            ],
          ),
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
        backgroundColor: Color(0xff193566),
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
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              child: Image.asset(
                  'assets/images/semi circle.png', height: size.height),
            ),
            Positioned(
              top: 35,
              child: Text(
                  'CLIENT INFO',textScaleFactor: 2,
                  style: TextStyle(
                      color: Color(0xff193566), fontWeight: FontWeight.bold)),
            ),
            Positioned(
              top: 80,

              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),

                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/tarek.jpg'),
                  radius: 80,
                ),
              ),
            ),
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
                children:
                Clients.map((p) {
                  return personDetailCard(p);
                }).toList()
            ),
            Positioned(
              bottom: 220,
              child: Text(
                  'Client Requested RSA',textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Color(0xff193566), fontWeight: FontWeight.bold)),
            ),
            Positioned(
              bottom: 200,
              child: Text(
                  DateTime.now().toString(),textScaleFactor: 1.5,
                  style: TextStyle(
                      color: Color(0xff193566), fontWeight: FontWeight.bold)),
            ),
            Positioned(
              bottom: 100,
              child: FloatingActionButton.extended(
                  onPressed: (){}, label: Text('Report'),backgroundColor:Color(0xff193566) , icon: Icon(Icons.report),)
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