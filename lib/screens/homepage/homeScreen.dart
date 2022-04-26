import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/screens/homepage/testscreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static final routeName = "/homescreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child:ElevatedButton(
        onPressed: (){
          context.go(SetAvalability.routeName);
        }, child:Text("press here") ,
      )));

  }
}
