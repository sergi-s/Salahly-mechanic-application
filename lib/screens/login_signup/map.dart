import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salahly_models/models/location.dart';

import '../../widgets/location/location_widget.dart';

class Map_Registration extends StatefulWidget {
  const Map_Registration({Key? key}) : super(key: key);
  static const String routeName = '/map';
  static CustomLocation? location;

  @override
  State<Map_Registration> createState() => Map_RegistrationState();
}

class Map_RegistrationState extends State<Map_Registration> {
  GlobalKey<MapWidgetState> myMapWidgetState = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MapWidget(key: myMapWidgetState),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: RaisedButton(
                    color: const Color(0xFF193566),
                    child: Text(
                      "confirm",
                      style: TextStyle(color: Colors.white),
                    ).tr(),
                    elevation: 5,
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(10)),
                    onPressed: () async {
                      await myMapWidgetState.currentState!.locatePosition();
                      Map_Registration.location =
                          myMapWidgetState.currentState?.currentCustomLoc;
                      print("${Map_Registration.location.toString()}cccccc");
                      Navigator.pop(context);
                    }),
              ),
            ],
          )
        ],
      ),
    );
  }
}
