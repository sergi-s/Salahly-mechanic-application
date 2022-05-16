// Global for anyone to use it
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salahly_mechanic/classes/scheduler/scheduler.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:time_planner/time_planner.dart';

// final schedulerTasksProvider =
// ChangeNotifierProvider<SchedulerTasksNotifier>((ref) {
//   return SchedulerTasksNotifier(ref);
// });
final schedulerTasksChangeProvider =
ChangeNotifierProvider((ref) {
  return SchedulerTasksChangeNotifier(ref);
});

class SchedulerTasksChangeNotifier extends ChangeNotifier {
  SchedulerTasksChangeNotifier(this.ref) : super() {
    // List<ScheduleTask> tasks = [];
    // Scheduler.getTasks().then((tasksReturned) {
    //   if(tasksReturned != null) {
    //     tasks = tasksReturned;
    //     notifyListeners();
    //   }
    // });
  }
  List<ScheduleTask> tasks = [];

  final Ref ref;

  // void addTask(TimePlannerTask task) {
  //   // state = List.from(state)..add(task);
  //   state = [...state, task];
  //   print("addTask: ${state.length}");
  //   state = state;
  // }
  //
  // void removeTask(TimePlannerTask task) {
  //   state = List.from(state)..remove(task);
  // }

  List<ScheduleTask> getTasks() {
    return tasks;
  }

  void addTask(ScheduleTask task) {
    // change notifier
    tasks.add(task);
    notifyListeners();

    // state notifier
    // state = [...state, task];
  }

  void removeTask(ScheduleTask task) {
    // change notifier
    for (var element in tasks) {
      if(element.id == task.id && element.id == task.id) {
        tasks.remove(element);
      }
    }
    notifyListeners();

    // state notifier
    // state = state.where((element) => element.id != task.id).toList();
  }

}
