import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/global_widgets/app_bar.dart';

class PendingRequestsScreen extends StatefulWidget {
  static const String routeName = "/pendingrequests";
  const PendingRequestsScreen({Key? key}) : super(key: key);

  @override
  State<PendingRequestsScreen> createState() => _PendingRequestsScreenState();
}

class _PendingRequestsScreenState extends State<PendingRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  salahlyAppBar(),
      backgroundColor: const Color(0xFFd1d9e6),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.2,),
            Container(
                height: MediaQuery.of(context).size.height*0.27,
                width: MediaQuery.of(context).size.width*0.46,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/pending.gif"),
                      fit: BoxFit.cover),
                ),
               // Foreground widget here
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.85,
              child: Text(
                "Your registration request is pending, please wait until it is approved",
                style: TextStyle(
                  fontSize:19,
                  // letterSpacing: 1,
                  color: Color(0xFF193566),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
