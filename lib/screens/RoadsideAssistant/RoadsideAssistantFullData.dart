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
    DateTime now = DateTime.now();
    final String name = Client.name;
    final String carnumber = Client.carnumber;
    final String mobilenumber = Client.mobilenumber;
    final String carmodel = Client.carmodel;
    final String color = Client.color;
    final String image = Client.image;
    final String subscribtionlevel = Client.subscribtionlevel;
    return Container(
      alignment: Alignment.center,
      child: Center(
      child:Card(
      color: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin:const EdgeInsets.symmetric(vertical:6,horizontal:25 ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            ListTile(
              leading:Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 6.0,right: 10.0),
                child: Icon(CupertinoIcons.profile_circled,color:Color(0xff97a7c3),size: 45)),
              title: Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 6.0,right: 8.0),
                child: Text(name, textScaleFactor: 1.2, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold)).tr(),),
            ),
            ListTile(
              leading:Padding(
                  padding: const EdgeInsets.only(top:6.0,bottom: 6.0,right: 8.0),
                  child: Icon(CupertinoIcons.car_detailed,color:Color(0xff97a7c3),size: 45)),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child:Text(carnumber,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child:Text(carmodel,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                  Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child:Text(color,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                ],),
            ),
            ListTile(
              leading:Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 6.0,right: 10.0),
                  child: Icon(CupertinoIcons.device_phone_portrait,color:Color(0xff97a7c3),size: 45)),
              title: Padding(
                padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                child:Text(mobilenumber,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
            ),
            ListTile(
              leading:Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 15.0,right: 10.0),
                  child: Icon(CupertinoIcons.plus_rectangle_on_rectangle,color:Color(0xff97a7c3),size: 40)),
              title: Padding(
                padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                child:Text(subscribtionlevel,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
            ),
            ListTile(
              leading:Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 15.0,right: 10.0),
                  child: Icon(CupertinoIcons.location,color:Color(0xff97a7c3),size: 45)),
              title: Padding(
                padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                child:Text('Location : Moharam Bek - Alex - 22 nasr ahmed zaki',textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
            ),
            ListTile(
              leading:Padding(
                  padding: const EdgeInsets.only(top:10.0,bottom: 15.0,right: 10.0),
                  child: Icon(CupertinoIcons.car_fill,color:Color(0xff97a7c3),size: 45)),
              title: Padding(
                padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                child:Text('Client Requested RSA  ${now.day.toString().padLeft(2,'0')}-${now.month.toString().padLeft(2,'0')}-${now.year.toString()}'+'   '+'${now.hour.toString().padLeft(2,'0')}:${now.minute.toString().padLeft(2,'0')}',textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
            ),
   ],
          ),
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
      backgroundColor: const Color(0xFFd1d9e6),

      appBar: AppBar(
        title: Text('RSA Full Data'),
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
              title: const Text('OnGoing Requests',
                  style: TextStyle(fontWeight: FontWeight.bold)).tr(),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                  'Set availability', style: TextStyle(fontWeight: FontWeight.bold))
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
          top:35,
          left: 25,
          right: 25,
          child: Column(
                    children:
                    Clients.map((p) {
                      return personDetailCard(p);
                    }).toList()),
             ),
            Positioned(
              bottom: 200,
                left: 80,
                right: 80,
              child: FloatingActionButton.extended(
                  onPressed: (){

                  }, label: const Text('Rsa Report'),backgroundColor:const Color(0xff193566) , icon: const Icon(Icons.fact_check_rounded)),
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