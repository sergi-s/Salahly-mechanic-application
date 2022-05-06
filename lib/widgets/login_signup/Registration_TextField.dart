import 'package:flutter/material.dart';

import 'Input_container.dart';

// ignore: camel_case_types
class Registration_Input extends StatefulWidget {
  Registration_Input({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.fn,
  }) : super(key: key);
  final String hintText;
  final IconData icon;
  final Function fn;

  @override
  State<Registration_Input> createState() => _Registration_InputState();
}

class _Registration_InputState extends State<Registration_Input> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child: TextField(
        onChanged: (value) {
          widget.fn(value);
        },
        controller: _textEditingController,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: Colors.blue,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
