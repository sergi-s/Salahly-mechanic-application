import 'package:flutter/material.dart';

import 'Input_container.dart';

// ignore: camel_case_types
class InputTextField extends StatelessWidget {
  InputTextField({
    Key? key,
    required this.hintText,

     required this.fn,
  }) : super(key: key);
  final String hintText;

  final TextEditingController _textEditingController = TextEditingController();
   final Function fn;

  @override
  Widget build(BuildContext context) {
  return InputContainer(
    child: TextField(

      onChanged: (value)  {
        _textEditingController.text=value;
        fn(value);

      },

      cursorColor: Colors.blue,
      decoration: InputDecoration(
        hintText: hintText,
        border: InputBorder.none,
      ),

    ),
  );
  }
}
