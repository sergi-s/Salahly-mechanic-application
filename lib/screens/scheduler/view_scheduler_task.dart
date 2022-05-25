import 'package:easy_localization/easy_localization.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

import '../../classes/scheduler/scheduler.dart';

class ViewSchedulerTaskScreen extends StatefulWidget {
  ViewSchedulerTaskScreen({required this.scheduleTaskAndFunctionOnDelete}) {
    // onDelete = scheduleTaskAndFunctionOnDelete["onDelete"];
    scheduleTask = scheduleTaskAndFunctionOnDelete["scheduleTask"];
  }

  static const String routeName = '/view_scheduler_task';
  final Map<String, dynamic> scheduleTaskAndFunctionOnDelete;
  late Function onDelete;
  late ScheduleTask scheduleTask;
  static bool deleted = false;

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
              Navigator.of(context).pop();
            },
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(""),
            Text(
              "view_time_planner".tr(),
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 16, left: 16.0, right: 16.0, bottom: 32),
            child: SingleChildScrollView(
              child: Container(
                // height: MediaQuery.of(context).size.height *2,
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 6,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Container(
                        // height: MediaQuery.of(context).size.height * 1.98,
                        color: Colors.blueGrey[50],
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [ Expanded(
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
                                                firstStr: "start_date".tr() + ":",
                                                secondStr:
                                                    "${widget.scheduleTask.startDate.day}/${widget.scheduleTask.startDate.month}/${widget.scheduleTask.startDate.year}"),
                                          MyTwoEndTextDivided(
                                              firstStr: "start_time".tr() + ":",
                                              secondStr:
                                                  "${(widget.scheduleTask.startDate.hour).floor()}:${widget.scheduleTask.startDate.minute}"),
                                          if (widget.scheduleTask.endDate != null)
                                            MyTwoEndTextDivided(
                                                firstStr: "end_time".tr() + ":",
                                                secondStr:
                                                    "${(widget.scheduleTask.endDate?.hour)?.floor()}:${widget.scheduleTask.endDate?.minute}"),
                                          if (widget.scheduleTask.duration != null)
                                            MyTwoEndTextDivided(
                                                firstStr: "duration".tr() + ":",
                                                secondStr:
                                                    "${((widget.scheduleTask.duration)! / 60).floor()}:${(widget.scheduleTask.duration)! % 60}"),
                                          // MyTwoEndTextDivided(
                                          //     firstStr: "description".tr()+":",
                                          //     secondStr:
                                          //
                                                //      "${widget.scheduleTask.description}"),

                                                if (widget.scheduleTask.requestObject !=
                                                  null &&
                                              widget.scheduleTask.requestObject!
                                                      .car !=
                                                  null)
                                            MyTwoEndTextDivided(
                                                firstStr: "car_number".tr() + ":",
                                                secondStr:
                                                    "${widget.scheduleTask.requestObject!.car!.noPlate}"),
                                          Row(
                                            children: [
                                              MyTwoEndTextDivided(
                                                  firstStr: "color".tr() + ":",
                                                  secondStr: ""),
                                              CircleAvatar(
                                                backgroundColor:
                                                    widget.scheduleTask.color,
                                              )
                                            ],
                                          ),
                                          if (widget.scheduleTask.description != "")
                                            MyTwoEndTextDivided(
                                              firstStr:
                                              "description".tr() + ":",
                                              secondStr: '',
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(width: MediaQuery.of(context).size.width*0.3,),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.51,
                                                  child: ExpandableText(
                                                    // 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                                    "${widget.scheduleTask.description}",
                                                    expandText: ' more',
                                                    collapseText: ' less',
                                                    maxLines: 2,
                                                    linkColor: Colors.grey[400],
                                                  ),
                                                )
                                              ],
                                            )
                                          // if (widget.scheduleTask.requestObject !=
                                          //     null)
                                          //   MyTwoEndTextDivided(
                                          //       firstStr: "request".tr() + ":",
                                          //       secondStr:
                                          //           "${(widget.scheduleTask.requestObject)}"),
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
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            RaisedButton(
                                                child: Text(
                                                  "delete_task".tr(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: const Color(0xFF193566),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(12)),
                                                onPressed: () async {
                                                  await Scheduler.deleteTask(
                                                      widget.scheduleTask);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                              'deleted_scheduler_task'
                                                                  .tr())));
                                                  ViewSchedulerTaskScreen.deleted =
                                                      true;
                                                  Navigator.pop(context);
                                                }),
                                            RaisedButton(
                                                child: Text(
                                                  "close".tr(),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: const Color(0xFF193566),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(12)),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                }),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
