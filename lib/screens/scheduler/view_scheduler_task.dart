import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

import '../../classes/scheduler/scheduler.dart';

class ViewSchedulerTaskScreen extends StatefulWidget {
  ViewSchedulerTaskScreen({required this.scheduleTaskAndFunctionOnDelete}){
    onDelete = scheduleTaskAndFunctionOnDelete["onDelete"];
    scheduleTask  = scheduleTaskAndFunctionOnDelete["scheduleTask"];
  }
  static const String routeName = '/view_scheduler_task';
  final Map<String,dynamic> scheduleTaskAndFunctionOnDelete;
  late Function onDelete;
  late ScheduleTask scheduleTask;

  @override
  _ViewSchedulerTaskState createState() => _ViewSchedulerTaskState();
}

class _ViewSchedulerTaskState extends State<ViewSchedulerTaskScreen> {
  _text(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w600,
        color: Color.fromARGB(255, 0, 0, 0),
      ),
    );
  }

  _title(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 30.0,
        fontWeight: FontWeight.bold,
        color: Color(0xFF193566),
      ),
    );
  }

  _renderRequestObject(RSA rsa) {
    return Column(
      children: <Widget>[
        _text(tr('request_type') + " : ${rsa.requestType}"),
        _text(tr('request_status') + " : ${rsa.state}"),
        _text(tr('car_number') + " : ${rsa.state}"),
        _text(tr('car_model') + " : ${rsa.car!.model}"),
        _text(tr('client_name') + " : ${rsa.user!.name}"),
        _text(tr('phone_number') + " : ${rsa.user!.phoneNumber}"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
             },
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(""),
            const Text(
              "View Scheduler",
              style: TextStyle(
                fontSize: 20,
                // letterSpacing: 1.5,
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
            // Container(
            //   decoration: const BoxDecoration(
            //       image: DecorationImage(
            //           image: AssetImage("assets/images/mechanic.png"), fit: BoxFit.cover)),
            // ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 16, left: 16.0, right: 16.0, bottom: 32),
                child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.8,
                    child: Card(
                      elevation: 6,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        color: Colors.blueGrey[50],
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment:
                              //     MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.04),
                                const Center(
                                  child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        "assets/images/mechanic.png"),
                                  ),
                                ),
                                // SizedBox(
                                //     height: MediaQuery.of(context).size.height *
                                //         0.05),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Center(
                                    child:
                                        _title(" ${widget.scheduleTask.title}"),
                                  ),
                                ),
                                // SizedBox(
                                //     height: MediaQuery.of(context).size.height *
                                //         0.08),
                                // Padding(
                                //   padding: const EdgeInsets.only(bottom: 8),
                                //   child: Center(
                                //       child: Text('smallDescription',
                                //           style: const TextStyle(
                                //               fontSize: 18,
                                //               fontWeight: FontWeight.w600))),
                                // ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.03),
                                DefaultTextStyle(
                                  style: const TextStyle(
                                      color: Color(0xFF193566),
                                      fontWeight: FontWeight.normal,
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 18),
                                  child: Column(
                                    children: [
                                      if (widget.scheduleTask.startDate != null)
                                        MyTwoEndTextDivided(
                                            firstStr: "Start Date :",
                                            secondStr:
                                                "${widget.scheduleTask.startDate.day}/${widget.scheduleTask.startDate.month}/${widget.scheduleTask.startDate.year}"),
                                      MyTwoEndTextDivided(
                                          firstStr: "Start Time :",
                                          secondStr:
                                              "${(widget.scheduleTask.startDate.hour).floor()}:${widget.scheduleTask.startDate.minute}"),

                                      if (widget.scheduleTask.endDate != null)
                                        MyTwoEndTextDivided(
                                            firstStr: "End Time :",
                                            secondStr:
                                                "${(widget.scheduleTask.endDate?.hour)?.floor()}:${widget.scheduleTask.endDate?.minute}"),
                                      if (widget.scheduleTask.duration != null)
                                        MyTwoEndTextDivided(
                                            firstStr: "Duration :",
                                            secondStr:
                                                "${((widget.scheduleTask.duration)!/ 60).floor()}:${(widget.scheduleTask.duration)! % 60}"),
                                      Row(
                                        children: [
                                          const MyTwoEndTextDivided(
                                              firstStr: "Color :",
                                              secondStr: ""),
                                          CircleAvatar(
                                            backgroundColor:
                                                widget.scheduleTask.color,
                                          )
                                        ],
                                      ),
                                      if (widget.scheduleTask.requestObject !=
                                          null)
                                        MyTwoEndTextDivided(
                                            firstStr: "Request :",
                                            secondStr:
                                                "${(widget.scheduleTask.requestObject)}"),
                                      if (widget.scheduleTask.description !=
                                          null)
                                        MyTwoEndTextDivided(
                                            firstStr: "Description :",
                                            secondStr:
                                                "${widget.scheduleTask.description}"),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RaisedButton(
                                            child: Text(
                                              "Delete task",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: const Color(0xFF193566),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            onPressed: () async {
                                              await Scheduler.deleteTask(widget.scheduleTask);
                                              await widget.onDelete();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                      content: Text('Deleted scheduler task'.tr())));
                                              Navigator.pop(context);
                                            }),
                                        RaisedButton(
                                            child: Text(
                                              "Okay",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: const Color(0xFF193566),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(12)),
                                            onPressed: () {}),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }
}

class MyTwoEndTextDivided extends StatelessWidget {
  final String? firstStr, secondStr;

  const MyTwoEndTextDivided({required this.firstStr, required this.secondStr});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(firstStr!),
        ),
        // const Expanded(
        //     child: Divider(
        //       thickness: 2,
        //       color: Colors.grey,
        //     )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(secondStr!),
        ),
      ],
    );
  }
}
//  _text('title'.tr() + ": ${widget.scheduleTask.title}"),
//               if(widget.scheduleTask.description != null)
//                 _text('description'.tr() + ": ${widget.scheduleTask.description}"),
//               _text('start_date'.tr() +
//                   ": ${widget.scheduleTask.startDate.day}/${widget.scheduleTask
//                       .startDate.month}/${widget.scheduleTask.startDate.year}"),
//               _text('start_time'.tr() +
//                   ": ${widget.scheduleTask.startDate.hour}:${widget.scheduleTask
//                       .startDate.minute}"),
//               _text(duration'.tr() + ": ${(widget.scheduleTask.duration)!/60}:${(widget.scheduleTask.duration)!%60}"),
//               Row(
//                 children: [
//                   _text('color'.tr()),
//                   CircleAvatar(backgroundColor: widget.scheduleTask.color,)
//                 ],
//               ),
//
//               if(widget.scheduleTask.requestObject != null)
//                 _renderRequestObject(widget.scheduleTask.requestObject!),
