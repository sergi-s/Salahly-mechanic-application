import 'package:flutter/material.dart';

class InputContainer extends StatelessWidget {
  const InputContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width*0.8,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color:Colors.grey[200],
          boxShadow:[
            BoxShadow(
              color: Colors.blueGrey,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset:Offset(3,0),

            ),
          ]
      ),

      child: child,
    );
  }
}