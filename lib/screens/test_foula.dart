import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/provider/ongoing_requests_notifier.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/homepage/set_availaibility.dart';
import 'package:salahly_mechanic/screens/login_signup/signupscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScreenFoula extends ConsumerWidget {
  static const routeName = "/testscreenfoula";
  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
              context.go(LoginSignupScreen.routeName);
            }, child: const Text('Sign out')),
            ElevatedButton(onPressed: (){

              context.push(SetAvailability.routeName);
            }, child: const Text('set availability screen')),
            ElevatedButton(onPressed: () async {
              /*final prefs = await SharedPreferences.getInstance();
              final rsaID =  await prefs.getString("rsaID").toString();
              print("RSA ID: "+rsaID);
              final userID = await FirebaseAuth.instance.currentUser!.uid;
              dbRef.child("rsa").child(rsaID).child("mechanicsResponses").child(userID).set("accepted");*/

              dbRef.child("rsa").child(ref.watch(pendingRequestsProvider)[0].rsaID!).child("mechanicsResponses").child( FirebaseAuth.instance.currentUser!.uid).set("accepted");
            }, child: const Text('accept rsa request')),
            Text("RSA TEST "+(ref.watch(pendingRequestsProvider).length >0? ref.watch(pendingRequestsProvider)[0].state.toString():"BEFORE")),
            ElevatedButton(onPressed: (){
              ref.watch(pendingRequestsProvider.notifier).changeState();
            }, child: Text('Change description'))
          ],
        ),
      ),
    );
  }
}
/*
userID,
lat,
long,
providerResponses,
mechanicResponses,
state

isCenter: false,
      avatar: "",
      phoneNumber: "1231231234",
      id: id,
      name: (ds.child("name").value).toString(),
      email: (ds.child("email").value).toString(),
      rating: toDouble((ds.child("rating").value).toString()));
 */