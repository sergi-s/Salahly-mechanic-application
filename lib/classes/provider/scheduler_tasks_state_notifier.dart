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
final schedulerTasksProvider =
StateNotifierProvider<SchedulerTasksNotifier,List<ScheduleTask>>((ref) {
  return SchedulerTasksNotifier(ref);
});

class SchedulerTasksNotifier extends StateNotifier<List<ScheduleTask>> {
  SchedulerTasksNotifier(this.ref) : super([]) {
    // Scheduler.getTasks().then((tasks) {
    //   if(tasks != null) {
    //     state = tasks;
    //     print("got tasks and inserted into SM");
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

  void addTask(ScheduleTask task) {
    // change notifier
    // tasks.add(task);
    // notifyListeners();

    // state notifier
    state = [...state, task];
  }

  void removeTask(ScheduleTask task) {
    // change notifier
    // tasks.forEach((element) {
    //   if(element.id == task.id && element.id == task.id) {
    //     tasks.remove(element);
    //   }
    // });
    // notifyListeners();

    // state notifier
    state = state.where((element) => element.id != task.id).toList();
  }

}
