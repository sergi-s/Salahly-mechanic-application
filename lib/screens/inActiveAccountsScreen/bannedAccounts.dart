import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/global_widgets/app_bar.dart';

class BanAccount extends StatefulWidget {
  static const String routeName = "/banAccount";
  const BanAccount({Key? key}) : super(key: key);

  @override
  State<BanAccount> createState() => _BanAccountState();
}

class _BanAccountState extends State<BanAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  salahlyAppBar(),
      backgroundColor: const Color(0xFFd1d9e6),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.12,),
            Container(
              height: MediaQuery.of(context).size.height*0.3,
              width: MediaQuery.of(context).size.width*0.53,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/error.gif"),
                    fit: BoxFit.cover),
              ),
              // Foreground widget here
            ),
            // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(  width: MediaQuery.of(context).size.width*0.04),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.6,
                  child: Text(
                    "Your account is banned",
                    style: TextStyle(
                      fontSize:20,
                      // letterSpacing: 1,
                      color: Color(0xFF193566),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
