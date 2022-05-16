import 'package:flutter/material.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

class ScheduleTask {
  final String? key;
  DateTime startDate;
  String title;
  String? description;
  Color color;
  int id;
  String? requestId;
  DateTime? endDate;
  int? duration;
  RSA? requestObject;

  ScheduleTask({
    required this.startDate,
    required this.title,
    required this.color,
    required this.id,
    this.description,
    this.requestId,
    this.endDate,
    this.duration,
    this.requestObject,
    this.key,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id': id,
      'title': title,
      'color': color.value,
      'startDate': startDate.millisecondsSinceEpoch,
    };
    if (endDate != null) {
      map['endDate'] = endDate!.millisecondsSinceEpoch;
    }
    if (description != null) {
      map['description'] = description;
    }
    if (requestId != null) {
      map['requestId'] = requestId;
    }
    if (duration != null) {
      map['duration'] = duration;
    }
    if (key != null) {
      map['key'] = key;
    }
    return map;
  }


  factory ScheduleTask.fromMap(Map<String, dynamic> map) {
    return ScheduleTask(
      id: map['id'],
      title: map['title'],
      color: Color(map['color']),
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      description: map['description'],
      requestId: map['requestId'],
      endDate: map['endDate'] != null ? DateTime.fromMillisecondsSinceEpoch(map['endDate']) : null,
      duration: map['duration'],
      requestObject: map['requestObject'],
      key: map['key'],
    );
  }


}
