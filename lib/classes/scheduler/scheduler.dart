import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';
import 'package:salahly_mechanic/model/schedule_task.dart';
import 'package:time_planner/time_planner.dart';

class Scheduler {
  static final _db = Localstore.instance;
  static List<ScheduleTask>? tasks;

  static Future<List<ScheduleTask>?> getTasks() async {
    tasks ?? await getAllFromStorage();
    return tasks;
  }

  static Future addTask(ScheduleTask scheduleTask) async {
    if (tasks == null) await getTasks();
    tasks!.add(scheduleTask);
    _db
        .collection('todos')
        .doc(scheduleTask.id.toString())
        .set(scheduleTask.toMap());
    return true;
  }

  static Future deleteTask(ScheduleTask scheduleTask) async {
    if (tasks == null) return false;
    _db.collection('todos').doc(scheduleTask.id.toString()).delete();
    if (tasks!.contains(scheduleTask)) {
      tasks!.remove(scheduleTask);
      return true;
    }
    return false;
  }

  static Future deleteTaskById(int id) async {
    if (tasks == null) return false;
    _db.collection('todos').doc(id.toString()).delete();
    for (var i in tasks!) {
      if (i.id == id) {
        tasks!.remove(i);
        return true;
      }
    }
    return false;
  }

  static resetTasks() {
    tasks = null;
  }

  static getAllFromStorage() async {
    tasks = [];
    final result = await _db.collection('todos').get();
    result?.forEach((key, value) {
      tasks!.add(ScheduleTask.fromMap(value));
    });
  }
}
