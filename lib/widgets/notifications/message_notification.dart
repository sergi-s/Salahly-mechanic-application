import 'package:flutter/material.dart';

class MessageNotification extends StatelessWidget {
  final VoidCallback onReplay;

  MessageNotification({required this.onReplay});

  @override
  Widget build(BuildContext context) {

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: ListTile(
          leading: SizedBox.fromSize(
            size: const Size(40, 40),
            child: ClipOval(child: Icon(Icons.watch)),
          ),
          title: Text('Lily MacDonald'),
          subtitle: Text('Do you want to see a movie?'),
          trailing: IconButton(
              icon: Icon(Icons.reply),
              onPressed: () {
                ///TODO i'm not sure it should be use this widget' BuildContext to create a Dialog
                ///maybe i will give the answer in the future
                if (onReplay != null) onReplay();
              }),
        ),
      ),
    );
  }
}
