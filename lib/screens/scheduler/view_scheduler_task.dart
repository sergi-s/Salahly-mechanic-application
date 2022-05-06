import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:salahly_mechanic/widgets/report/input_textfield.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

class ViewSchedulerTaskScreen extends StatefulWidget {
  const ViewSchedulerTaskScreen({Key? key, required this.scheduleTask})
      : super(key: key);
  static const String routeName = '/view_scheduler_task';
  final ScheduleTask scheduleTask;

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

  _renderRequestObject(RSA rsa) {
    return Column(
      children: <Widget>[
        _text(tr('request_type')+" : ${rsa.requestType}"),
        _text(tr('request_status')+" : ${rsa.state}"),
        _text(tr('car_number')+" : ${rsa.state}"),
        _text(tr('car_model')+" : ${rsa.car!.model}"),
        _text(tr('client_name')+" : ${rsa.user!.name}"),
        _text(tr('phone_number')+" : ${rsa.user!.phoneNumber}"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              _text('title'.tr() + ": ${widget.scheduleTask.title}"),
              if(widget.scheduleTask.description != null)
                _text('description'.tr() + ": ${widget.scheduleTask.description}"),
              _text('start_date'.tr() +
                  ": ${widget.scheduleTask.startDate.day}/${widget.scheduleTask
                      .startDate.month}/${widget.scheduleTask.startDate.year}"),
              _text('start_time'.tr() +
                  ": ${widget.scheduleTask.startDate.hour}:${widget.scheduleTask
                      .startDate.minute}"),
              _text('duration'.tr() + ": ${(widget.scheduleTask.duration)!/60}:${(widget.scheduleTask.duration)!%60}"),
              Row(
                children: [
                  _text('color'.tr()),
                  CircleAvatar(backgroundColor: widget.scheduleTask.color,)
                ],
              ),

              if(widget.scheduleTask.requestObject != null)
                _renderRequestObject(widget.scheduleTask.requestObject!),

              // InputTextField(
              //   hintText: 'title',
              //   fn: (){
              //
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
