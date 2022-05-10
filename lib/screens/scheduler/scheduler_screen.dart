import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/scheduler/scheduler.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:salahly_mechanic/screens/scheduler/view_scheduler_task.dart';
import 'package:time_planner/time_planner.dart';

import 'add_scheduler_task.dart';

class SchedulerScreen extends StatefulWidget {
  const SchedulerScreen({Key? key}) : super(key: key);
  static const String routeName = '/schedulerScreen';

  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  List<TimePlannerTask> tasks = [];
  Map<int, bool> cache = {};

  _refreshRenderList() async {
    List<ScheduleTask>? savedTasks = Scheduler.getTasks();
    if (savedTasks == null) {
      await Scheduler.getAllFromStorage();
      savedTasks = Scheduler.getTasks();
    }
    for (var element in savedTasks!) {
      if (!cache.containsKey(element.id)) {
        cache[element.id] = true;
        setState(() {
          tasks.add(toTimePlannerTask(element));
        });
        /*TimePlannerTask(
            minutesDuration: element.duration!,
            dateTime: TimePlannerDateTime(
                day: element.startDate.day,
                hour: element.startDate.hour,
                minutes: element.startDate.minute),
            color: element.color,
            child: Text(element.title),
            onTap: () {
              context.push(ViewSchedulerTaskScreen.routeName, extra: element);
            })*/

      }
    }
  }

  @override
  void initState() {
    super.initState();
    _refreshRenderList();
/*    tasks =
    [
      TimePlannerTask(
        // background color for task
        color: Colors.purple,
        // day: Index of header, hour: Task will be begin at this hour
        // minutes: Task will be begin at this minutes
        dateTime: TimePlannerDateTime(day: 0, hour: 14, minutes: 30),
        // Minutes duration of task
        minutesDuration: 90,
        // Days duration of task (use for multi days task)
        daysDuration: 1,
        onTap: () {
          context.go(
            ViewSchedulerTaskScreen.routeName,
            extra: ScheduleTask(
                startDate: DateTime(2020, 5, 3, 14, 30),
                title: "Task title",
                color: Colors.purple,
                id: 1,
                duration: 90,
                requestObject: RSA(
                  user: Client(name: "Ahmed", phoneNumber: "0123456789"),
                  car: Car(
                    model: "Corolla",
                    noPlate: '12345',
                  ),
                )),
          );
        },
        child: Text(
          'this is a task',
          style: TextStyle(color: Colors.grey[350], fontSize: 12),
        ),
      ),
      TimePlannerTask(
        // background color for task
        color: Colors.purple,
        // day: Index of header, hour: Task will be begin at this hour
        // minutes: Task will be begin at this minutes
        dateTime: TimePlannerDateTime(day: 1, hour: 14, minutes: 30),
        // Minutes duration of task
        minutesDuration: 90,
        // Days duration of task (use for multi days task)
        daysDuration: 2,
        onTap: () {},
        child: Text(
          'this is a task',
          style: TextStyle(color: Colors.grey[350], fontSize: 12),
        ),
      ),
      TimePlannerTask(
        // background color for task
        color: Colors.purple,
        // day: Index of header, hour: Task will be begin at this hour
        // minutes: Task will be begin at this minutes
        dateTime: TimePlannerDateTime(day: 4, hour: 15, minutes: 2),
        // Minutes duration of task
        minutesDuration: 144,
        // Days duration of task (use for multi days task)
        daysDuration: 1,
        onTap: () {},
        child: Text(
          'this is a task',
          style: TextStyle(color: Colors.grey[350], fontSize: 12),
        ),
      ),
    ];*/
  }

  _prepareDay(int day){
    DateTime nw = DateTime.now();
    // 1 -> 7, 8 -> 14, 16 -> 22,
    // previous, current, next
    Random rnd = Random();
    return rnd.nextInt(10)+1;
  }



  TimePlannerTask toTimePlannerTask(ScheduleTask scheduleTask) {
    return TimePlannerTask(
      child: Text(scheduleTask.title),
      color: scheduleTask.color,
      dateTime: TimePlannerDateTime(
          day: _prepareDay(scheduleTask.startDate.day),
          hour: scheduleTask.startDate.hour,
          minutes: scheduleTask.startDate.minute),
      minutesDuration: scheduleTask.duration!,
      onTap: () {
        context.push(
          ViewSchedulerTaskScreen.routeName,
          extra: scheduleTask,
        );
      },
    );
  }

  final Color previousWeek = Colors.redAccent,
      thisWeek = Colors.blue,
      nextWeek = Colors.green;

  _addTask() async {
    await Scheduler.addTask(ScheduleTask(startDate: DateTime.now(), title: "title 3", color: Colors.greenAccent, id: 5,duration: 120));
    await _refreshRenderList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTask();
          context.go(AddSchedulerTaskScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: TimePlanner(
          // time will be start at this hour on table
          startHour: 0,
          // time will be end at this hour on table
          endHour: 23,
          // each header is a column and a day
          headers: [
            TimePlannerTitle(
              date: "Previous week",
              title: "Saturday",
              titleStyle:
                  TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: previousWeek,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Previous week",
              title: "Sunday",
              titleStyle:
                  TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: previousWeek,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Previous week",
              title: "Monday",
              titleStyle:
                  TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: previousWeek,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Previous week",
              title: "Tuesday",
              titleStyle:
                  TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: previousWeek,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            TimePlannerTitle(

              date: "Previous week",
              title: "Wednesday",
              titleStyle:
                  TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: previousWeek,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Previous week",
              title: "Thursday",
              titleStyle:
                  TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: previousWeek,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Previous week",
              title: "Friday",
              titleStyle:
                  TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: previousWeek,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
            ),
            TimePlannerTitle(
              date: "This week",
              title: "Saturday",
              titleStyle:
                  TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "This week",
              title: "Sunday",
              titleStyle:
                  TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "This week",
              title: "Monday",
              titleStyle:
                  TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "This week",
              title: "Tuesday",
              titleStyle:
                  TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "This week",
              title: "Wednesday",
              titleStyle:
                  TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "This week",
              title: "Thursday",
              titleStyle:
                  TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "This week",
              title: "Friday",
              titleStyle:
                  TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Next week",
              title: "Saturday",
              titleStyle:
                  TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Next week",
              title: "Sunday",
              titleStyle:
                  TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Next week",
              title: "Monday",
              titleStyle:
                  TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Next week",
              title: "Tuesday",
              titleStyle:
                  TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Next week",
              title: "Wednesday",
              titleStyle:
                  TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Next week",
              title: "Thursday",
              titleStyle:
                  TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
            TimePlannerTitle(
              date: "Next week",
              title: "Friday",
              titleStyle:
                  TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
              dateStyle: TextStyle(
                  color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ],
          // List of task will be show on the time planner
          tasks: tasks,
        ),
      ),
    );
  }
}
