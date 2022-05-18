import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/reportscreen.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_drawer.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

class DoneRequestsFullData extends StatefulWidget {
  DoneRequestsFullData(
  // {
  //   // required this.rsa
  // }
  );
  static final routeName = "/donerequestsfulldata";
  // RSA rsa;
  @override
  State<DoneRequestsFullData> createState() => _DoneRequestsFullDataState();
}

class _DoneRequestsFullDataState extends State<DoneRequestsFullData> {
  late RSA rsa;

  @override
  void initState() {
    // rsa = widget.rsa;
    super.initState();
  }

  Widget personDetailCard(RSA rsa) {

    final String name = rsa.user!.name??"Client name";
    final String carNumber = rsa.car != null ?rsa.car!.noPlate:"Car number";
    final String mobileNumber = rsa.user!.phoneNumber??"Phone number";
    final String carModel = rsa.car != null ?rsa.car!.model!:"Car model";
    final String color = rsa.car != null ?rsa.car!.color!:"0xFF00FF00";
    final String image =  rsa.user!.avatar??"";
    print("name = $name");
    print("carNumber = $carNumber");
    print("mobileNumber = $mobileNumber");
    print("carModel = $carModel");
    print("color = $color");
    print("image = $image");

    return SingleChildScrollView(
      child: Container(
        height: MediaQuery
            .of(context)
            .size.height*0.89,
        alignment: Alignment.center,
        child: Card(
          color: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          margin:const EdgeInsets.symmetric(vertical:6,horizontal:25 ),
          child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                ListTile(
                  leading:Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(CupertinoIcons.profile_circled,color:Color(0xff97a7c3),size: 45)),
                  title: Padding(
                    padding: const EdgeInsets.only(top:10.0,bottom: 6.0,right: 8.0),
                    child: Text(name, textScaleFactor: 1.2, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold)).tr(),),
                ),
                ListTile(
                  leading:Padding(
                      padding: const EdgeInsets.only(top:6.0,bottom: 6.0,right: 8.0),
                      child: Icon(CupertinoIcons.car_detailed,color:Color(int.parse(color)),size: 45)),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                        child:Text(carNumber,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                      Padding(
                        padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                        child:Text(carModel,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),

                    ],),
                ),
                ListTile(
                  leading:Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 6.0,right: 10.0),
                      child: Icon(CupertinoIcons.device_phone_portrait,color:Color(0xff97a7c3),size: 45)),
                  title: Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child:Text(mobileNumber,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                ),

                ListTile(
                  leading:Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 15.0,right: 10.0),
                      child: Icon(CupertinoIcons.location,color:Color(0xff97a7c3),size: 45)),
                  title: Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child:Text(rsa.location!.name!,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                ),
                ListTile(
                  leading:Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 15.0,right: 10.0),
                      child: Icon(CupertinoIcons.car_fill,color:Color(0xff97a7c3),size: 45)),
                  title: Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child:Text('Client Requested RSA',textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                ),
                ListTile(
                  leading:Padding(
                      padding: const EdgeInsets.only(top:10.0,bottom: 15.0,right: 10.0),
                      child: Icon(Icons.article_outlined,color:Color(0xff97a7c3),size: 45)),
                  title: Padding(
                    padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                    child:Container(
                      child: Row(
                        children:<Widget> [
                          Expanded(child: Text('Client Requested RSA Client Client Requested RSA Client Client Requested RSA ClientClient Requested RSA ClientClient Requested RSA ClientClient Requested RSA ClientClient Requested RSA ClientClient Requested RSA ClientClient Requested RSA Client Requested RSA Client Requested RSA Client Requested RSA',textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.normal,fontSize:15),textAlign: TextAlign.left).tr()),
                        ],
                      ),
                    ),),
                ),
                SizedBox(height:MediaQuery.of(context).size.height*0.02),
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
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

      appBar: salahlyAppBar(),

      drawer: salahlyDrawer(context),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(

                child:
                Column(
                    children:[
                      personDetailCard(rsa)
                    ]
                ),
              ),

            ],
          ),
        ),
      ),

    );
  }
}