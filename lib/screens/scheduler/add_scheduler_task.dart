import 'dart:core';
import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/classes/provider/scheduler_tasks_change_notifier.dart';
import 'package:salahly_mechanic/classes/provider/scheduler_tasks_state_notifier.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/widgets/add_Schedular/number_input.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

import '../../classes/scheduler/scheduler.dart';
import '../../model/schedule_task.dart';
import '../../widgets/add_Schedular/select_textfield.dart';
import '../../widgets/add_Schedular/text_input.dart';
import '../../widgets/progress_dialog/progress_dialog.dart';

class AddSchedulerTaskScreen extends ConsumerStatefulWidget {
  static const String routeName = '/add_scheduler_task';
  final Function onAdd;
  static ScheduleTask? newTask;
  AddSchedulerTaskScreen({required this.onAdd});

  @override
  _AddSchedulerTaskScreenState createState() => _AddSchedulerTaskScreenState();
}

class _AddSchedulerTaskScreenState
    extends ConsumerState<AddSchedulerTaskScreen> {
  int totalTasks = 0;
  List<RSA>? ongoingReqs;

  @override
  initState() {
    super.initState();
    Scheduler.getTasks().then((value) {
      setState(() {
        totalTasks = value != null ? value.length : 0;
      });
    });

    DateTime _nowDateTime = DateTime.now();
    setState(() {
      dateTime =
          DateTime(_nowDateTime.year, _nowDateTime.month, _nowDateTime.day);
    });
  }

  _getOngoingReqs() {
    if (_requestsItems.isNotEmpty) return;
    ongoingReqs = ref.watch(ongoingRequestsProvider);
    if (ongoingReqs != null) {
      _requestsItems.add("None");
      for (RSA req in ongoingReqs!) {
        setState(() {
          _requestsItems.add(req.car!.noPlate);
        });
      }
    }
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
    // print("datetime: ${dateTime!}");
    dateTime = dateTime!
        .add(Duration(hours: timeOfDay!.hour, minutes: timeOfDay!.minute));
    // print("Duration ${Duration(hours: timeOfDay!.hour, minutes: timeOfDay!.minute)}");
    // print("add task");
    // print("time of day: ${timeOfDay!.hour}:${timeOfDay!.minute}");
    // print("datetime: ${dateTime!}");
    // print("title: ${title}");
    // print("duration: ${_duration.toString()}");
    // print("color: ${pickerColor}");
    // print("id: ${totalTasks + 1}");
    // print("description: ${description}");
    int nextId = (Scheduler.tasks!.length+1)+5;
    while(true){
      if(Scheduler.tasks!.any((element) => element.id == nextId)){
        nextId++;
      }else{
        break;
      }
    }
    ScheduleTask task = ScheduleTask(
      startDate: dateTime!,
      title: title,
      color: pickerColor,
      id: nextId,
      duration: _hours * 60 + _minutes,
      description: description,
      requestObject: _selectedRequest,
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('added_scheduler'.tr())));
    print("title ${task.title}");
    AddSchedulerTaskScreen.newTask = task;
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
  int _hours = 2, _minutes = 0;
  List<String> _requestsItems = [];
  RSA? _selectedRequest;

  _timePicker(BuildContext context) async {
    timeOfDay = await showTimePicker(
      context: context,
      initialTime: timeOfDay ?? TimeOfDay.now(),
    );
    setState(() {});
  }

  _datePicker(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    setState(() {
      dateTime = _pickerDate;
    });
  }

  // create some values

// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _getOngoingReqs();
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
            "add_scheduler".tr(),
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: size.width * 0.88,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              MyInputField(
                fn: () {},
                title: "start_date".tr(),
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
              MyInputField(
                fn: () {},
                title: 'start_time'.tr(),
                hint: "${timeOfDay!.hour}:${timeOfDay!.minute}",
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Text(
                    'duration'.tr(),
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF193566)),
                  ),
              Row(
                children: [
                  Expanded(
                      child: MyNumberInputField(
initialValue: 2,
                          title: "hours".tr(),
                          hint: "2",
                          fn: (value) {
                            _hours = int.parse(value);
                          })),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  Expanded(
                      child: MyNumberInputField(
                          initialValue: 0,
                          title: "minutes".tr(),
                          hint: "00",
                          fn: (value) {
                            _minutes = int.parse(value);
                          })),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              MyInputField(
                  title: "title".tr(),
                  hint: "title".tr(),
                  fn: (updatedTitle) {
                    title = updatedTitle;
                  }),
              MyInputField(
                  title: "description".tr(),
                  hint: "description".tr(),
                  fn: (updatedDescription) {
                    description = updatedDescription;
                  }),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              _requestsItems.isNotEmpty
                  ? SelectRequest(
                      items: _requestsItems,
                      onChangedfunction: (value) {
                        if (value == "None") {
                          _selectedRequest = null;
                        } else {
                          if (ongoingReqs != null) {
                            for (RSA req in ongoingReqs!) {
                              if (req.car!.noPlate == value) {
                                _selectedRequest = req;
                              }
                            }
                          }
                        }
                      },
                      hintText: '',
                      title: "select_car".tr(),
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  Text(
                    "color_picker".tr(),
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
                            builder: (BuildContext context) => ProgressDialog(
                                message: "adding_schedule_please_wait".tr()));
                        await _addTask();
                        Navigator.pop(context);
                        isLoading = false;
                      },
                      child: Text(
                        "add".tr(),
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
            insetPadding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.03, vertical: MediaQuery.of(context).size.width*0.04),
            title: Text("pick_color".tr()),
            content: Column(
              children: [
                buildColorPicker(),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TextButton(
                      //     onPressed: () {
                      //       Navigator.of(context).pop();
                      //     },
                      //     child: Text("cancel".tr())),
                      // SizedBox(
                      //   width: 20,
                      // ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("select_color".tr())
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
