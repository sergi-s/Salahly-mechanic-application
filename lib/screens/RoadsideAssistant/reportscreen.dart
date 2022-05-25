import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/firebase/firebase.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/widgets/report/input_textfield.dart';
import 'package:salahly_mechanic/widgets/report/report_textfield.dart';
import 'package:salahly_mechanic/widgets/report/select_button.dart';
import 'package:salahly_models/models/report.dart';

class ReportScreen extends ConsumerWidget {
  static final routeName = "/reportscreen";

  ReportScreen({Key? key, required this.rsaId, required this.requestType})
      : super(key: key);
  final TextEditingController _textEditingController = TextEditingController();
  final String rsaId;
  final String requestType;

  String cartype = "";
  String system_name = "";
  String part_id = "";
  String part_name = "";
  var actual_distance;

  var distance;

  var part_cost;

  var maint_cost;
  var other_cost;

  String maint_description = "";
  FirebaseCustom fb = FirebaseCustom();

  updatetype(String tp) {
    cartype = tp;
  }

  updatesystemname(String sn) {
    system_name = sn;
  }

  updatepartid(String pi) {
    part_id = pi;
  }

  updatepartname(String pn) {
    part_name = pn;
  }

  updateactualdistance(String ad) {
    actual_distance = double.parse(ad.toString());
  }

  updatedistance(String dt) {
    distance = double.parse(dt.toString());
  }

  updatepartcost(String pc) {
    part_cost = double.parse(pc.toString());
  }

  updatemaintcost(String mc) {
    maint_cost = double.parse(mc.toString());
  }

  updateothercost(String oc) {
    other_cost = double.parse(oc.toString());
  }

  updatemaintdescription(String md) {
    maint_description = md;
  }

  reportOnPress(BuildContext context,WidgetRef ref) async {
    Report report = Report(
        systemName: system_name,
        partID: part_id,
        actualDistance: actual_distance,
        otherCost: other_cost,
        partCost: part_cost,
        partName: part_name,
        // carType:cartype,
        maintenanceCost: maint_cost,
        // distance:distance,
        maintenanceDescription: maint_description);
    bool check = await fb.report(report, rsaId, requestType);
    if (check) {
      ref.watch(ongoingRequestsProvider.notifier).removeRSAById(rsaId);
      Navigator.of(context).pop();
    }
    if (requestType != "wsa" && requestType != "rsa" && requestType != "tta") {

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('wrong_request'.tr()+" "+requestType)));
    } else if (check) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('data_saved_successfully'.tr())));
      const SnackBar(content: Text('Data Saved Successfully'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('failed_to_save'.tr())));
      const SnackBar(content: Text('Failed To Save'));
    }
  }

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF193566),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () { },
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(""),
          Text(
            "Report".tr(),
            style: TextStyle(
              fontSize: 25,
              letterSpacing: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          Image.asset(
            'assets/images/logo white.png',
            fit: BoxFit.contain,
            height: 32,
          ),
        ]),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
              // margin: EdgeInsets.symmetric(vertical: 150),
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(rsaId),
                    // SizedBox(height:180),
                    SizedBox(
                      width: 20,
                    ),
                    SelectTextField(
                        hintText: 'Select Car Type'.tr(),
                        items: ['Automatic'.tr(), 'Manual'.tr()],
                        onChangedfunction: updatetype),

                    InputTextField(
                        hintText: 'System Name'.tr(), fn: updatesystemname),
                    InputTextField(
                      hintText: 'Part Id'.tr(),
                      fn: updatepartid,
                    ),
                    InputTextField(
                      hintText: 'Part Name'.tr(),
                      fn: updatepartname,
                    ),
                    InputTextField(
                      hintText: 'Actual Distance'.tr(),
                      fn: updateactualdistance,
                    ),
                    InputTextField(
                      hintText: 'Distance'.tr(),
                      fn: updatedistance,
                    ),
                    InputTextField(
                      hintText: 'Part Cost'.tr(),
                      fn: updatepartcost,
                    ),
                    InputTextField(
                      hintText: 'Maintance Cost'.tr(),
                      fn: updatemaintcost,
                    ),

                    InputTextField(
                      hintText: 'Other Cost'.tr(),
                      fn: updateothercost,
                    ),
                    BuildMultipleTextField(
                      hintText: 'description'.tr(),
                      fn: updatemaintdescription,
                    ),
                    // ignore: deprecated_member_use
                    RaisedButton(
                      child: Text(
                        "Submit".tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Color(0xFF193566),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      onPressed: () {
                        if (system_name == "" && cartype == "") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('please_add_fields'.tr())));
                          const SnackBar(content: Text('Please Add Fields'));
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40)),
                                elevation: 16,
                                child: Container(
                                  height:
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .height / 1.6,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .height,
                                  child: ListView(
                                    children: <Widget>[
                                      SizedBox(height: 20),
                                      Center(
                                        child: Text(
                                          "Report".tr(),
                                          style: TextStyle(
                                              decoration:
                                              TextDecoration.underline,
                                              fontSize: 30,
                                              letterSpacing: 2,
                                              color: Color(0xFF193566),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Car Type :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                cartype,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "System Name:".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                system_name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Part Id :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                part_id,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Part Name :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                part_name,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Actual Distance :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                actual_distance.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Distance :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                distance.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Part Cost :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                part_cost.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Maintance Cost :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                maint_cost.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Other Cost :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                other_cost.toString(),
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.normal,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Description :".tr(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF193566)),
                                              ),
                                              SizedBox(
                                                width: 10, height: 10,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Text(
                                                    maint_description,
                                                    softWrap: true,
                                                    overflow:
                                                    TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.normal,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(
                                      //       left: 70, top: 20),
                                      SizedBox(height: 40,),
                                         Column(
                                           mainAxisAlignment: MainAxisAlignment.end,
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                RaisedButton(
                                                  color: Colors.blueGrey[300],
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    "Cancel".tr(),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                RaisedButton(
                                                  color: Color(0xFF193566),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                                  onPressed: () {
                                                    reportOnPress(context,ref);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "Confirm".tr(),
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                        ),
                                           ],
                                         ),

                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }
                      },),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
                // RoundedButton(title: "Register", onPressedFunction: () async {
                // registerOnPress(context);
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF193566);
    Path path = Path()
      ..relativeLineTo(0, 50)
      ..quadraticBezierTo(size.width / 2, 90, size.width, 50)
      ..relativeLineTo(0, -50)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
