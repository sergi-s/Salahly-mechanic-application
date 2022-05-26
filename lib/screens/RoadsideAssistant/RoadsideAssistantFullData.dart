import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/semi_report_screen.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_drawer.dart';
import 'package:salahly_models/abstract_classes/user.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

class RequestFullDataScreen extends StatefulWidget {
  RequestFullDataScreen({required this.rsa});

  static const routeName = "/roadsideassistantfulldata";
  RSA rsa;

  @override
  State<RequestFullDataScreen> createState() => _RequestFullDataScreenState();
}

class _RequestFullDataScreenState extends State<RequestFullDataScreen> {
  late RSA rsa;
  Type? typeOfUser;

  @override
  void initState() {
    getUserType().then((value) => setState(() {
          typeOfUser = value;
        }));
    rsa = widget.rsa;
    super.initState();
  }

  Widget personDetailCard(RSA rsa) {
    final String name = rsa.user!.name ?? "Client name";
    final String carNumber = rsa.car != null ? rsa.car!.noPlate : "Car number";
    final String mobileNumber = rsa.user!.phoneNumber ?? "Phone number";
    final String carModel = rsa.car != null ? rsa.car!.model! : "Car model";
    final Color color = rsa.car != null ? rsa.car!.color! : Color(0xFF00FF00);
    final String image = rsa.user!.avatar ?? "";
    // print("name = $name");
    // print("carNumber = $carNumber");
    // print("mobileNumber = $mobileNumber");
    // print("carModel = $carModel");
    // print("color = $color");
    // print("image = $image");

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      alignment: Alignment.center,
      child: Card(
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 25),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height:MediaQuery.of(context).size.height*0.02),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/report.png"),
              radius: MediaQuery.of(context).size.height*0.06,
            ),SizedBox(height:MediaQuery.of(context).size.height*0.02),
            ListTile(
              leading: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 6.0, right: 10.0),
                  child: Icon(CupertinoIcons.profile_circled,
                      color: Color(0xff97a7c3), size: 45)),
              title: Padding(
                padding:
                    const EdgeInsets.only(top: 10.0, bottom: 6.0, right: 8.0),
                child: Text(name,
                        textScaleFactor: 1.2,
                        style: const TextStyle(
                            color: Color(0xff193566),
                            fontWeight: FontWeight.bold))
                    .tr(),
              ),
            ),
            ListTile(
              leading: Padding(
                  padding:
                      const EdgeInsets.only(top: 6.0, bottom: 6.0, right: 8.0),
                  child: Icon(CupertinoIcons.car_detailed,
                      color: color, size: 45)),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    child: Text(carNumber,
                            textScaleFactor: 1.1,
                            style: const TextStyle(
                                color: Color(0xff193566),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left)
                        .tr(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                    child: Text(carModel,
                            textScaleFactor: 1.1,
                            style: const TextStyle(
                                color: Color(0xff193566),
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left)
                        .tr(),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
                  //   child:Text(color,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
                ],
              ),
            ),
            ListTile(
              leading: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 6.0, right: 10.0),
                  child: Icon(CupertinoIcons.device_phone_portrait,
                      color: Color(0xff97a7c3), size: 45)),
              title: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: Text(mobileNumber,
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                            color: Color(0xff193566),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left)
                    .tr(),
              ),
            ),
            // ListTile(
            //   leading:Padding(
            //       padding: const EdgeInsets.only(top:10.0,bottom: 15.0,right: 10.0),
            //       child: Icon(CupertinoIcons.plus_rectangle_on_rectangle,color:Color(0xff97a7c3),size: 40)),
            //   title: Padding(
            //     padding: const EdgeInsets.only(top:6.0,bottom: 6.0),
            //     child:Text(subscriptionLevel,textScaleFactor: 1.1, style: const TextStyle(color: Color(0xff193566), fontWeight: FontWeight.bold),textAlign: TextAlign.left).tr(),),
            // ),
            ListTile(
              leading: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 15.0, right: 10.0),
                  child: Icon(CupertinoIcons.location,
                      color: Color(0xff97a7c3), size: 45)),
              title: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: Text(rsa.location!.name!,
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                            color: Color(0xff193566),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left)
                    .tr(),
              ),
            ),
            ListTile(
              leading: Padding(
                  padding: const EdgeInsets.only(
                      top: 10.0, bottom: 15.0, right: 10.0),
                  child: Icon(CupertinoIcons.car_fill,
                      color: Color(0xff97a7c3), size: 45)),
              title: Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 6.0),
                child: Text('Client Requested RSA',
                        textScaleFactor: 1.1,
                        style: const TextStyle(
                            color: Color(0xff193566),
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left)
                    .tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: salahlyAppBar(context, title: 'Request_details'.tr()),
      drawer: salahlyDrawer(context),
      body: SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Positioned(
              child: Column(children: [personDetailCard(rsa)]),
            ),
            Positioned(
              bottom: 50,
               left: 60,
              // right: 80,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: (typeOfUser != null && typeOfUser == Type.mechanic)
                    ? [
                  // SizedBox(width: MediaQuery.of(context).size.width*0.03,),
                        RaisedButton(  color: Color(0xFF193566),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () {
                              context.push(SemiReportScreen.routeName,
                                  extra: rsa);
                            },
                            child: Text('update_fixing_initial_report'.tr(),style: TextStyle(color: Colors.white))),
                  SizedBox(width: MediaQuery.of(context).size.width*0.02,),
                  RaisedButton(  color: Color(0xFF193566),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                            onPressed: () {
                              context.pushNamed("ReportScreen", params: {
                                "requestType": RSA
                                    .requestTypeToString(rsa.requestType!)
                                    .toLowerCase(),
                                "rsaId": rsa.rsaID!
                              });
                            },
                            child: Text('ReportScreen'.tr(),style: TextStyle(color: Colors.white))),
                        // FloatingActionButton.extended(
                        //     onPressed: () {
                        //       context.push(SemiReportScreen.routeName, extra: rsa);
                        //     },
                        //     label: Text('update_fixing_initial_report'.tr()),
                        //     backgroundColor: const Color(0xff193566),
                        //     icon: const Icon(Icons.fact_check_rounded)),
                        // FloatingActionButton.extended(
                        //     onPressed: () {
                        //       context.pushNamed("ReportScreen", params: {
                        //         "requestType": RSA
                        //             .requestTypeToString(rsa.requestType!)
                        //             .toLowerCase(),
                        //         "rsaId": rsa.rsaID!
                        //       });
                        //     },
                        //     label: const Text('Rsa Report'),
                        //     backgroundColor: const Color(0xff193566),
                        //     icon: const Icon(Icons.fact_check_rounded))
                      ]
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
