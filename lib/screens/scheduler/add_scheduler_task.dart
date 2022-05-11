import 'dart:core';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../classes/scheduler/scheduler.dart';
import '../../model/schedule_task.dart';
import '../../widgets/add_Schedular/select_textfield.dart';
import '../../widgets/add_Schedular/text_input.dart';
import '../../widgets/progress_dialog/progress_dialog.dart';

class AddSchedulerTaskScreen extends ConsumerStatefulWidget {
  static const String routeName = '/add_scheduler_task';
  final Function onAdd;


  AddSchedulerTaskScreen({required this.onAdd});

  @override
  _AddSchedulerTaskScreenState createState() => _AddSchedulerTaskScreenState();
}

class _AddSchedulerTaskScreenState
    extends ConsumerState<AddSchedulerTaskScreen> {
  int totalTasks = 0;

  @override
  initState() {
    super.initState();
    Scheduler.getTasks().then((value) {
      setState(() {
        totalTasks = value != null ? value.length : 0;
      });
    });
  }

  _addRandomTask() async {
    Random rnd = Random();
    // return rnd.nextInt(10)+1;
    await Scheduler.addTask(ScheduleTask(
      startDate: DateTime.now()
          .add(Duration(days: rnd.nextInt(12) - 5, hours: rnd.nextInt(12) - 5)),
      title: "title " + (++totalTasks).toString(),
      color: Colors.greenAccent,
      id: totalTasks,
      duration: 120,
    ));
    // await _refreshRenderList();
  }

  _addTask() async {
    dateTime =  dateTime!.add(Duration(hours: timeOfDay!.hour, minutes: timeOfDay!.minute));
    print("Duration ${Duration(hours: timeOfDay!.hour, minutes: timeOfDay!.minute)}");
    print("add task");
    print("time of day: ${timeOfDay!.hour}:${timeOfDay!.minute}");
    print("datetime: ${dateTime!}");
    print("title: ${title}");
    print("duration: ${_duration.toString()}");
    print("color: ${pickerColor}");
    print("id: ${totalTasks+1}");
    print("description: ${description}");

    await Scheduler.addTask(ScheduleTask(
      startDate: dateTime!,
      title: title,
      color: pickerColor,
      id: ++totalTasks,
      duration: _duration,
      description: description,
    ));
    await widget.onAdd();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Added scheduler'.tr())));
    Navigator.pop(context);

    // await _refreshRenderList();
  }

  // final DateTime? _selectedDate = DateTime.now();
  // TimeOfDay startSelectedTime = TimeOfDay.now();
  int _duration = 90;
  TimeOfDay? timeOfDay = TimeOfDay.now();
  DateTime? dateTime = DateTime.now();
  String description = "", title = "";
  Color pickerColor = Color(0xff443a49);
  // Color currentColor = Color(0xff443a49);
  // String? color;

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
  
  bool isLoading = false;
  
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
                      hint: DateFormat.yMMMEd().format(dateTime!),
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
                                "${timeOfDay!.hour}:${timeOfDay!.minute}",
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
                        Expanded(
                            flex: 8,
                            child: MyInputField(
                                title: "Duration", hint: "Hours", fn: () {})),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.02,
                        ),
                        Expanded(
                            flex: 8,
                            child: MyInputField(
                                title: "", hint: "Minutes", fn: () {})),
                      ],
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    SelectRequest(
                      items: ["RSA", "WSA"],
                      onChangedfunction: () {},
                      hintText: '',
                      title: "Request Type",
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                    MyInputField(
                        title: "Title", hint: "Title", fn: (updatedTitle) {
                      title = updatedTitle;
                    }),
                    MyInputField(
                        title: "Description", hint: "Description", fn: (updatedDescription) {
                          description = updatedDescription;
                    }),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(
                      children: [
                        Text(
                          "Color Picker",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF193566)),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        GestureDetector(
                          onTap: () {
                            pickColor(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: pickerColor),
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
                            onPressed: () async {
                              isLoading = true;
                              showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          ProgressDialog(message: "Adding schedule, please wait"));
                              await _addTask();
                              Navigator.pop(context);
                              isLoading = false;
                            },
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
