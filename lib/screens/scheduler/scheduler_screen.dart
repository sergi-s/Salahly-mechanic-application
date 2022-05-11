import 'dart:math';
import 'package:intl/intl.dart';

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

class DaysObject {
  DateTime date;
  WeekEnum weekEnum;

  DaysObject({required this.date, required this.weekEnum});
}

enum WeekEnum { previous, current, next }

class _SchedulerScreenState extends State<SchedulerScreen> {
  List<TimePlannerTask> tasks = [];
  Map<int, bool> cache = {};
  int totalTasks = 0;

  _refreshRenderList() async {
    print("hello");
    List<ScheduleTask>? savedTasks = await Scheduler.getTasks();
    totalTasks = savedTasks?.length ?? 0;
    // if (savedTasks == null) {
    //   await Scheduler.getAllFromStorage();
    //   savedTasks = Scheduler.getTasks();
    // }
    for (var element in savedTasks!) {
      if (!cache.containsKey(element.id)) {
        cache[element.id] = true;
        setState(() {
          dynamic v = toTimePlannerTask(element);
          if (v != null) {
            tasks.add(v);
          }
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
    // print(weekDays.length);
    // 1 -> 7, 8 -> 14, 16 -> 22,
    // previous, current, next
    //-7 -> -1, 0 -> 6, 7 -> 14
    for (var i = 0; i < 21; i++) {
      WeekEnum weekEnum;
      if (i < 7) {
        weekEnum = WeekEnum.previous;
      } else if (i < 14) {
        weekEnum = WeekEnum.current;
      } else {
        weekEnum = WeekEnum.next;
      }

      weekDays.add(DaysObject(
          date: DateTime.now().add(Duration(days: i-7)), weekEnum: weekEnum));
    }
    // print(weekDays[7].date.day);
    _getDaysList();
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

  compareDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  List<DaysObject> weekDays = [];
  List<TimePlannerTitle> weekDaysWidget = [];

  int? _prepareDay(ScheduleTask scheduleTask) {
    DateTime dateSaved = scheduleTask.startDate;
    // 1 -> 7, 8 -> 14, 16 -> 22,
    // previous, current, next

    bool found = false;
    int day = 0;
    //DateTime date in days
    for (int i = 0; i < weekDays.length; i++) {
      if (compareDay(dateSaved, weekDays[i].date)) {
        found = true;
        day = i;
        break;
      }
    }
    if (!found) {
      Scheduler.deleteTask(scheduleTask);
      return null;
    } else {
      return day;
    }
    // Random rnd = Random();
    // return rnd.nextInt(10)+1;
  }

  TimePlannerTask? toTimePlannerTask(ScheduleTask scheduleTask) {
    int? day = _prepareDay(scheduleTask);
    if (day == null) {
      return null;
    }
    Map<String,dynamic> map = {
      "scheduleTask": scheduleTask,
      "onDelete": _refreshRenderList
    };
    return TimePlannerTask(
      child: Text(scheduleTask.title),
      color: scheduleTask.color,
      dateTime: TimePlannerDateTime(
          day: day,
          hour: scheduleTask.startDate.hour,
          minutes: scheduleTask.startDate.minute),
      minutesDuration: scheduleTask.duration!,
      onTap: () {
        context.push(
          ViewSchedulerTaskScreen.routeName,
          extra: map,
        );
      },

    );
  }

  final Color previousWeek = Colors.redAccent,
      thisWeek = Colors.blue,
      nextWeek = Colors.green;

  _getDaysList() {
    // List<Widget> daysList = [];
    for (var day in weekDays) {
      if (day.weekEnum == WeekEnum.previous) {
        setState(() {
          weekDaysWidget.add(TimePlannerTitle(
            date: "Previous week",
            title: DateFormat('EEEE').format(day.date),
            titleStyle:
                TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
            dateStyle: TextStyle(
                color: previousWeek, fontWeight: FontWeight.bold, fontSize: 13),
          ));
        });
      }else if (day.weekEnum == WeekEnum.current) {
        setState(() {
          weekDaysWidget.add(TimePlannerTitle(
            date: "Current week",
            title: DateFormat('EEEE').format(day.date),
            titleStyle:
            TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
            dateStyle: TextStyle(
                color: thisWeek, fontWeight: FontWeight.bold, fontSize: 13),
          ));
        });
      }else {
        setState(() {
          weekDaysWidget.add(TimePlannerTitle(
            date: "Next week",
            title: DateFormat('EEEE').format(day.date),
            titleStyle:
            TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
            dateStyle: TextStyle(
                color: nextWeek, fontWeight: FontWeight.bold, fontSize: 13),
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // _addTask();
          context.push(AddSchedulerTaskScreen.routeName, extra: _refreshRenderList);
          // await _refreshRenderList();
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
          headers: weekDaysWidget,
          // List of task will be show on the time planner
          tasks: tasks,
        ),
      ),
    );
  }
}

/*
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
 */
