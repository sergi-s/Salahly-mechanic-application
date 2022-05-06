import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';

class AddSchedulerTaskScreen extends StatefulWidget {
  const AddSchedulerTaskScreen({Key? key}) : super(key: key);

  @override
  _AddSchedulerTaskScreenState createState() => _AddSchedulerTaskScreenState();
}

class _AddSchedulerTaskScreenState extends State<AddSchedulerTaskScreen> {
  TimeOfDay? timeOfDay = TimeOfDay.now();
  DateTime? dateTime = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _datePicker(context),
              child:
                  Text('Date: ${DateFormat('yyyy-MM-dd').format(dateTime!)}'),
            ),
            ElevatedButton(
              onPressed: () => _timePicker(context),
              child: Text(
                  'Time: ${MaterialLocalizations.of(context).formatTimeOfDay(timeOfDay!)}'), // ${TimeOfDayFormat.H_colon_mm('yyyy-MM-dd').format(timeOfDay!)}'),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                ScheduleTask scheduleTask = ScheduleTask(startDate: dateTime!, title: title, color: color, id: id);
              },
              child: Text('add_scheduler_task'),
            )
          ],
        ),
      ),
    );
  }
}
