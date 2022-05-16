import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/provider/scheduler_tasks_change_notifier.dart';
import 'package:salahly_mechanic/classes/provider/scheduler_tasks_state_notifier.dart';
import 'package:salahly_mechanic/classes/scheduler/scheduler.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:salahly_mechanic/screens/scheduler/view_scheduler_task.dart';
import 'package:time_planner/time_planner.dart';

import 'add_scheduler_task.dart';

class SchedulerScreen extends ConsumerStatefulWidget {
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

class _SchedulerScreenState extends ConsumerState<SchedulerScreen> {
  // List<TimePlannerTask> tasks = [];
  Map<int, bool> cache = {};
  int totalTasks = 0;

  _refreshRenderList() async {
    setState(() {
      todos = [];
    });
    List<ScheduleTask>? savedTasks = await Scheduler.getTasks();
    for (var element in savedTasks!) {
      dynamic v = toTimePlannerTask(element);
      if (!cache.containsKey(element.id) && element.id != 3) {// || true ||
        cache[element.id] = true;
        setState(() {
          todos.add(v);
        });
      }
    }
  }

  // List<TimePlannerTask> _renderList(List<ScheduleTask> tasks) {
  //   List<TimePlannerTask> list = [];
  //   for (var element in tasks) {
  //     dynamic v = toTimePlannerTask(element);
  //     if (v != null) {
  //       setState(() {
  //         list.add(v);
  //         todos.add(v);
  //       });
  //     }
  //   }
  //   return list;
  // }

  @override
  void dispose() {
    // print("Scheduler.tasks.length: ${Scheduler.tasks!.length}");
    Scheduler.resetTasks();
    // print("Scheduler.tasks is null: ${Scheduler.tasks == null}");
    // Scheduler.getAllFromStorage();
    // print("Scheduler.tasks is null: ${Scheduler.tasks == null}");
    super.dispose();
  }

  @override
  void initState() {
    _refreshRenderList();
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
          date: DateTime.now().add(Duration(days: i - 7)), weekEnum: weekEnum));
    }
    // print(weekDays[7].date.day);
    _getDaysList();

    // print(weekDays.length);
    // 1 -> 7, 8 -> 14, 16 -> 22,
    // previous, current, next
    //-7 -> -1, 0 -> 6, 7 -> 14


    super.initState();
  }

  compareDay(DateTime date1, DateTime date2) {
    return date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year;
  }

  List<DaysObject> weekDays = [];
  List<TimePlannerTitle> weekDaysWidget = [];

  // _addTaskToTimePlanner(ScheduleTask task) {
  //   // ref.watch(schedulerTasksProvider.notifier).addTask((task));
  //   ref.watch(schedulerTasksChangeProvider).addTask(task);
  // }

  // _deleteTaskToTimePlanner(ScheduleTask task) {
  //   // ref.watch(schedulerTasksProvider.notifier).removeTask((task));
  //   // ref.watch(schedulerTasksChangeProvider).addTask(task);
  // }

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
    Map<String, dynamic> map = {
      "scheduleTask": scheduleTask
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
        // Navigator.push(
        //   ViewSchedulerTaskScreen.routeName,
        //   extra: map,
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewSchedulerTaskScreen(
              scheduleTaskAndFunctionOnDelete: map,
            ),
          ),
        ).then((value) {

          if(ViewSchedulerTaskScreen.deleted) {
            setState(() {
              // _deleteTaskToTimePlanner(scheduleTask);
              // print("todos length: ${todos.length}");
              //   todos.remove(toTimePlannerTask(scheduleTask)!);
              // print("todos length: ${todos.length}");
              //   todos.forEach((element) {
              //     if(element.dateTime.day == scheduleTask.startDate.day && element.dateTime.hour == scheduleTask.startDate.hour && element.dateTime.minutes == scheduleTask.startDate.minute  && element.minutesDuration == scheduleTask.duration) {
              //       todos.remove(element);
              //       print("removed");
              //     }
              //   });
              // todos.removeAt(scheduleTask.id);
              });
            TimePlannerTask? t ;
            for (var element in todos) {
              if( element.dateTime.hour == scheduleTask.startDate.hour && element.dateTime.minutes == scheduleTask.startDate.minute  && element.minutesDuration == scheduleTask.duration) {
                t = element;
              }
            }
            if(t != null) {
              setState(() {
                todos.remove(t!);
              });
            }
              ViewSchedulerTaskScreen.deleted = false;
          }
        });
      },
    );
  }

  final Color previousWeek = Colors.redAccent,
      thisWeek = Colors.blue,
      nextWeek = Colors.green;

  _getDaysList() {
    for (var day in weekDays) {
      if (day.weekEnum == WeekEnum.previous) {
        setState(() {
          weekDaysWidget.add(TimePlannerTitle(
            date: "previous_week".tr(),
            title: DateFormat('EEEE').format(day.date).tr(),
            titleStyle:
                TextStyle(color: previousWeek, fontWeight: FontWeight.bold),
            dateStyle: TextStyle(
                color: previousWeek, fontWeight: FontWeight.bold, fontSize: 10),
          ));
        });
      } else if (day.weekEnum == WeekEnum.current) {
        setState(() {
          weekDaysWidget.add(TimePlannerTitle(
            date: "current_week".tr(),
            title: DateFormat('EEEE').format(day.date).tr(),
            titleStyle: TextStyle(color: thisWeek, fontWeight: FontWeight.bold),
            dateStyle: TextStyle(
                color: thisWeek, fontWeight: FontWeight.bold, fontSize: 10),
          ));
        });
      } else {
        setState(() {
          weekDaysWidget.add(TimePlannerTitle(
            date: "next_week".tr(),
            title: DateFormat('EEEE').format(day.date).tr(),
            titleStyle: TextStyle(color: nextWeek, fontWeight: FontWeight.bold),
            dateStyle: TextStyle(
                color: nextWeek, fontWeight: FontWeight.bold, fontSize: 10),
          ));
        });
      }
    }
  }

  List<TimePlannerTask> todos = [];

  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddSchedulerTaskScreen(
                        onAdd: (){},
                      ))).then((value) {
            //ez
            if (AddSchedulerTaskScreen.newTask != null) {
              setState(() {
                // print("added");
                // print("AddSchedulerTaskScreen.newTask.id: ${AddSchedulerTaskScreen.newTask!.id}");
                todos.add(toTimePlannerTask(AddSchedulerTaskScreen.newTask!)!);
              });
              Scheduler.addTask(AddSchedulerTaskScreen.newTask!);
              AddSchedulerTaskScreen.newTask = null;
            }
          });
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
          // tasks: todos,
          // tasks: _renderList(ref.watch(schedulerTasksProvider)),
          tasks: todos,
        ),
      ),
    );
  }
}
