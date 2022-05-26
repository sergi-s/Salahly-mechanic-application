import 'package:flutter/material.dart';

import 'Input_container.dart';

// ignore: camel_case_types
class BuildMultipleTextField extends StatefulWidget {
  BuildMultipleTextField({
    Key? key,
    required this.hintText,
    this.initialValue,
    required this.fn,
  }) : super(key: key);
  final String hintText;
  final String? initialValue;
  final Function fn;

  @override
  State<BuildMultipleTextField> createState() => _BuildMultipleTextFieldState();
}

class _BuildMultipleTextFieldState extends State<BuildMultipleTextField> {
  final TextEditingController _textEditingController = TextEditingController();

  bool first_time = true;

  @override
  Widget build(BuildContext context) {
    if (first_time && widget.initialValue != null) {
        setState(() {
          _textEditingController.text = widget.initialValue!;
        });
      first_time = false;
    }
    return InputContainer(
      child: TextField(
        controller: _textEditingController,
        onChanged: (value) {
          // _textEditingController.text = value;
          widget.fn(value);
        },
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
        maxLines: 10,
      ),
    );
  }
}
