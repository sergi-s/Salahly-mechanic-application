import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

import 'package:salahly_mechanic/widgets/report/report_textfield.dart';

class SemiReportScreen extends StatefulWidget {
  SemiReportScreen({Key? key,required this.rsa}) : super(key: key);
  static const String routeName = '/semi_report';
  RSA rsa;
  @override
  _SemiReportScreenState createState() => _SemiReportScreenState();
}

class _SemiReportScreenState extends State<SemiReportScreen> {
  String? description;
  late final String requestType;
  @override
  void initState() {
    super.initState();

    if(widget.rsa.requestType == null) return;
    // Get the previous description from the database
    requestType = RSA.requestTypeToString(widget.rsa.requestType!).toLowerCase();
    if(requestType == null) return;
    dbRef.child(requestType).child(widget.rsa.rsaID!).child('semi_report').get().then((snapshot) {
      if(snapshot.value == null) return;
      setState(() {
        description = snapshot.value.toString();
      });
    });
  }

  void _updateSemiReport(){
    if(description == null || description!.isEmpty) return;
    dbRef.child(requestType).child(widget.rsa.rsaID!).child('semi_report').set(description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: salahlyAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BuildMultipleTextField(
              initialValue: description,
              hintText: 'description'.tr(),
              fn: (value){ setState(() {
                description = value;
              });},
            ),
            ElevatedButton(onPressed: description!=null?(){
              _updateSemiReport();
              Navigator.of(context).pop();
            }:(){}, child: Text('update_report_state'.tr()),),
          ],
        ),
      )
    );
  }
}
