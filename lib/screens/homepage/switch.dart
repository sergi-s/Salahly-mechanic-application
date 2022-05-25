import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../classes/firebase/customgeofire.dart';
import '../../widgets/global_widgets/app_bar.dart';
import '../../widgets/global_widgets/app_drawer.dart';
// import 'package:flutter_icons/flutter_icons.dart';

class Switcher extends StatefulWidget {
  static final routeName = "/switcherscreen";

  Switcher({Key? key}) : super(key: key);

  @override
  _SwitcherState createState() => _SwitcherState();
}

NearbyLocations as = NearbyLocations();

class _SwitcherState extends State<Switcher> {
  late final _controller;
  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    getSavedAvailability();
  }

  void _startListener() {
    _controller.addListener(() {
      setState(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (_controller.value) {
          // boolean = true
          print("isAvailable: true");
          await NearbyLocations.setAvailabilityOn();
          prefs.setBool("isAvailable", true);
        } else {
          print("isAvailable: false");
          await NearbyLocations.setAvailabilityOff();
          prefs.setBool("isAvailable", false);
        }
      });
    });
  }

  getSavedAvailability() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isAvailableSP = prefs.getBool("isAvailable");
    if (isAvailableSP != null && isAvailableSP) {
      isAvailable = true;
    }
    _controller = ValueNotifier<bool>(isAvailable);
    _startListener();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFd1d9e6),
        appBar: salahlyAppBar(context, title: 'set_availability'.tr()),
        drawer: salahlyDrawer(context),
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildLabel('ON/OFF Switch'),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdvancedSwitch(
                    controller: _controller,
                    width: 80,
                    activeChild: Text('ON'),
                    inactiveChild: Text('OFF'),
                  ),
                ],
              ),
              // _buildLabel('XXS/XS Switch'),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     AdvancedSwitch(
              //       width: 16,
              //       height: 8,
              //       controller: _controller06,
              //     ),
              //     AdvancedSwitch(
              //       width: 32,
              //       height: 16,
              //       controller: _controller07,
              //     ),
              //   ],
              // ),
              // _buildLabel('S/M/L Switch'),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     AdvancedSwitch(
              //       width: 48,
              //       height: 24,
              //       controller: _controller08,
              //     ),
              //     AdvancedSwitch(
              //       width: 56,
              //       height: 28,
              //       controller: _controller09,
              //     ),
              //     AdvancedSwitch(
              //       width: 72,
              //       height: 36,
              //       controller: _controller10,
              //       borderRadius: BorderRadius.circular(18),
              //     ),
              //   ],
              // ),
              // _buildLabel('XL/XXL Switch'),
              // Row(
              //   mainAxisSize: MainAxisSize.max,
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     AdvancedSwitch(
              //       width: 96,
              //       height: 48,
              //       controller: _controller11,
              //       borderRadius: BorderRadius.circular(24),
              //     ),
              //     AdvancedSwitch(
              //       width: 112,
              //       height: 56,
              //       controller: _controller12,
              //       borderRadius: BorderRadius.circular(29),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String value) {
    return Container(
      margin: EdgeInsets.only(
        top: 25,
        bottom: 5,
      ),
      child: Text(
        '$value',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
