import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/add_Schedular/select_textfield.dart';
import '../../widgets/add_Schedular/text_input.dart';

class AddSchedulerTaskScreen extends ConsumerStatefulWidget {
  static const String routeName = '/add_scheduler_task';

  @override
  _AddSchedulerTaskScreenState createState() => _AddSchedulerTaskScreenState();
}

class _AddSchedulerTaskScreenState extends ConsumerState<AddSchedulerTaskScreen> {
  final DateTime? _selectedDate = DateTime.now();
  TimeOfDay startSelectedTime = TimeOfDay.now();
  int _duration = 0;
  TimeOfDay? timeOfDay = TimeOfDay.now();
  DateTime? dateTime = DateTime.now();
  String description="";
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  String? color;

  _timePicker(BuildContext context) async {
    timeOfDay = await showTimePicker(
      context: context,
      initialTime: timeOfDay ?? TimeOfDay.now(),
    );
  }

  _datePicker(BuildContext context) async {
    dateTime = await showDatePicker(
      context: context,
      initialDate: dateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }
 // create some values


// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF193566),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(""),
          Text(
            "Add Schedular".tr(),
            style: const TextStyle(
              fontSize: 20,
              letterSpacing: 1,
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: size.width * 0.88,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    MyInputField(
                      fn: () {},
                      title: "Start Date",
                      hint: DateFormat.yMMMEd().format(_selectedDate!),
                      widget: IconButton(
                        onPressed: () {
                          _datePicker(context);
                        },
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyInputField(
                            fn: () {},
                            title: 'Start Time',
                            hint:
                                "${startSelectedTime.hour}:${startSelectedTime.minute}",
                            widget: IconButton(
                              onPressed: () {
                                _timePicker(context);
                              },
                              icon: const Icon(
                                Icons.access_time_rounded,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                    Row(
                      children: [ 
                         Expanded(flex:8, child: MyInputField(title: "Duration", hint: "Hours", fn: (){})),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Expanded(flex:8,child: MyInputField(title: "", hint: "Minutes", fn: (){})),

                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SelectRequest(items: ["RSA","WSA"], onChangedfunction: (){},  hintText: '',title: "Request Type",),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                    MyInputField(title: "Description", hint: "Description", fn: (){}),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      children: [
                        Text("Color Picker",style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF193566)),),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            pickColor(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: pickerColor),
                            width: 50,
                            height: 50,
                          ),
                        ),

                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          // width: 95,
                          height: 50,
                          child: RaisedButton(
                            splashColor: Colors.white.withAlpha(40),
                            color: Color(0xFF193566),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            onPressed: () {},
                            child: Text(
                              "Add".tr(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildColorPicker() => ColorPicker(
      pickerColor: pickerColor,
      onColorChanged: (pickerColor) => setState(() {
            this.pickerColor = pickerColor;
          }));

  pickColor(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 60),
            title: Text("Pick Color"),
            content: Column(
              children: [
                buildColorPicker(),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("cancel".tr())),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Select Color".tr())),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
