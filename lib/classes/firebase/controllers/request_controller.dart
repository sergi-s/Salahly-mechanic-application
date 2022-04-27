

import 'package:firebase_database/firebase_database.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/utils/requests_memory_caching.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

loadRequestFromDB(String id,String requestType) async {
  DataSnapshot dataSnapshot = await dbRef.child(requestType).child(id).get();
  // double? latitude =
  //     double.parse(dataSnapshot.child("latitude").value.toString());
  // double? longitude =
  //     double.parse(dataSnapshot.child("longitude").value.toString());
  RequestType t = RSA.stringToRequestType(requestType.toUpperCase())!;
  RSA rsa = RSA(
    state: RSA.stringToState(dataSnapshot.child("state").value.toString()),
    rsaID: dataSnapshot.key.toString(),
    requestType: t,
    // location: CustomLocation(
    //   latitude: latitude, longitude: longitude,
    //   // name: dataSnapshot.child("address").value.toString(),
    // ),
    // report: Report()
  );
  rsaCache[rsa.rsaID!] = rsa;
  return rsa;
}