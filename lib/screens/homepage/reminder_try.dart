// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:reminders/reminders.dart';
//
//
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<dynamic> _allLists = [];
//   String _active;
//   bool _access = false;
//
//   @override
//   void initState() {
//     super.initState();
//     getLists();
//   }
//
//   Future<void> getLists() async {
//     bool access = await Reminders.hasAccess;
//     String defaultList = await Reminders.defaultList;
//     List<dynamic> allLists = await Reminders.allLists;
//
//     if (mounted)
//       setState(() {
//         _allLists = allLists;
//         _active = defaultList;
//         _access = access;
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const Text('iOS Reminders example app'),
//               Icon(
//                 _access ? Icons.check_box : Icons.close,
//                 size: 40.0,
//                 color: _access ? Colors.white : Colors.red,
//               ),
//             ],
//           ),
//         ),
//         body: Column(children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: _allLists
//                   .map((list) => GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _active = list as String;
//                     });
//                   },
//                   child: ListWidget(list, active: list == _active)))
//                   .toList(),
//             ),
//           ),
//           Flexible(
//             fit: FlexFit.tight,
//             child: FutureBuilder(
//                 future: Reminders.getReminders(_active),
//                 builder: (context, dataSnapshot) {
//                   if (dataSnapshot.connectionState == ConnectionState.waiting)
//                     return Center(child: CircularProgressIndicator());
//
//                   if (dataSnapshot.hasError) {
//                     print(dataSnapshot.error);
//                     return Text(dataSnapshot.error);
//                   }
//                   return ListView.builder(
//                     itemCount: dataSnapshot.data.length,
//                     itemBuilder: (context, index) => Dismissible(
//                       onDismissed: (direction) => setState(() {
//                         Reminders.deleteReminder(dataSnapshot.data[index].id);
//                       }),
//                       key: Key(dataSnapshot.data[index]?.title),
//                       child: ReminderWidget(dataSnapshot.data![index]),
//                     ),
//                   );
//                 }),
//           ),
//         ]),
//       ),
//     );
//   }
// }
//
// class ReminderWidget extends StatelessWidget {
//   final Reminder reminder;
//   ReminderWidget(this.reminder);
//
//   Icon _priorityIcon(int priority) {
//     switch (priority) {
//       case 0:
//         return Icon(Icons.trending_flat);
//       case 1:
//         return Icon(Icons.low_priority);
//       case 5:
//         return Icon(Icons.looks_two);
//       case 9:
//         return Icon(Icons.priority_high);
//       default:
//         return Icon(Icons.question_answer);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       leading: _priorityIcon(reminder.priority),
//       title: Text(reminder.title),
//       trailing: reminder.isCompleted
//           ? Icon(Icons.check_box_outlined)
//           : Icon(Icons.check_box_outline_blank),
//       subtitle: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           reminder.notes != ""
//               ? Text(reminder.notes)
//               : Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               reminder.dueDate != ""
//                   ? Text("Due: ${reminder.dueDate}")
//                   : Text(""),
//               reminder.isCompleted
//                   ? Text(
//                   "Completed: ${reminder.completionDate.split(" ")[0]}")
//                   : reminder.startDate != ""
//                   ? Text("Started: ${reminder.startDate}")
//                   : Text("")
//             ],
//           ),
//           reminder.notes != ""
//               ? Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               reminder.dueDate != ""
//                   ? Text("Due: ${reminder.dueDate}")
//                   : Text(""),
//               reminder.isCompleted
//                   ? Text(
//                   "Completed: ${reminder.completionDate.split(" ")[0]}")
//                   : reminder.startDate != ""
//                   ? Text("Started: ${reminder.startDate}")
//                   : Text("")
//             ],
//           )
//               : Text(""),
//         ],
//       ),
//       isThreeLine: reminder.notes != "",
//     );
//   }
// }
//
// class ListWidget extends StatelessWidget {
//   final dynamic list;
//   final bool active;
//
//   ListWidget(this.list, {this.active});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(18.0),
//       child: Text(
//         list as String,
//         style: TextStyle(
//             fontSize: 18.0,
//             fontWeight: FontWeight.bold,
//             decoration: active ? TextDecoration.underline : null),
//       ),
//     );
//   }
// }