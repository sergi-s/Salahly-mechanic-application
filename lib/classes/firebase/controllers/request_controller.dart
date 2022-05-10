import 'package:firebase_database/firebase_database.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/utils/requests_memory_caching.dart';
import 'package:salahly_models/models/car.dart';
import 'package:salahly_models/models/client.dart';
import 'package:salahly_models/models/location.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

loadRequestFromDB(String id, String requestType) async {
  DataSnapshot dataSnapshot = await dbRef.child(requestType).child(id).get();
  // double? latitude =
  //     double.parse(dataSnapshot.child("latitude").value.toString());
  // double? longitude =
  //     double.parse(dataSnapshot.child("longitude").value.toString());
  RequestType t = RSA.stringToRequestType(requestType.toUpperCase())!;
  DataSnapshot carSnapshot = await dbRef
      .child("cars")
      .child(dataSnapshot.child("carID").value.toString())
      .get();
  Car car = Car(
    color: carSnapshot.child("color").value.toString(),
    noPlate: carSnapshot.child("plate").value.toString(),
    model: carSnapshot.child("model").value.toString(),
  );
  DataSnapshot userSnapshot = await dbRef
      .child("users")
      .child("clients")
      .child(dataSnapshot.child("userID").value.toString())
      .get();

  if (car.color!.contains("(")) {
    car.color = car.color!
        .substring(car.color!.indexOf("(") + 1, car.color!.indexOf(")"));
  }
  RSA rsa = RSA(
    user: Client(
      name: userSnapshot.child("name").value.toString(),
      phoneNumber: userSnapshot.child("phoneNumber").value.toString(),
    ),
    car: car,
    state: RSA.stringToState(dataSnapshot.child("state").value.toString()),
    rsaID: dataSnapshot.key.toString(),
    requestType: t,
    location: CustomLocation(
      name: "Location",
      latitude: double.parse(dataSnapshot.child("latitude").value.toString()), longitude: double.parse(dataSnapshot.child("longitude").value.toString()),
      // name: dataSnapshot.child("address").value.toString(),
    ),
    // report: Report()
  );
  rsaCache[rsa.rsaID!] = rsa;
  return rsa;
}
