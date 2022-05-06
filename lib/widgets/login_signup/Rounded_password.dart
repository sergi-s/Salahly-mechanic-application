

import 'package:flutter/material.dart';
import 'package:salahly_mechanic/widgets/login_signup/Input_container.dart';

class RounedPasswordInput extends StatelessWidget {
   RounedPasswordInput({

    Key? key,
    required this.hint,
     required this.function,
  }) : super(key: key);

final String hint;
  final TextEditingController _textEditingController = TextEditingController();
  final Function function;
  @override
  Widget build(BuildContext context) {
    return InputContainer(
      child:TextField(

        onChanged: (value) {
          _textEditingController.text=value;
          function(value);

        },
        cursorColor: Colors.blue,
        obscureText: true,
        decoration:InputDecoration(
          icon:   Icon(Icons.lock,color: Color(0xFF193566),),
          hintText: hint,
          border: InputBorder.none,

        ),


      ),);
  }
}
