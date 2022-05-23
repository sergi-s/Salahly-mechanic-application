import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/utils/requests_memory_caching.dart';
import 'package:salahly_models/models/car.dart';
import 'package:salahly_models/models/client.dart';
import 'package:salahly_models/models/location.dart';
import 'package:salahly_models/models/mechanic.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

loadRequestFromDB(String id, String requestType) async {
  DataSnapshot dataSnapshot = await dbRef.child(requestType).child(id).get();
  // double? latitude =
  //     double.parse(dataSnapshot.child("latitude").value.toString());
  // double? longitude =
  //     double.parse(dataSnapshot.child("longitude").value.toString());
  print("->>>>>>>>>>>>>>$requestType");
  RequestType t = RSA.stringToRequestType(requestType.toUpperCase())!;
  DataSnapshot carSnapshot = await dbRef
      .child("cars")
      .child(dataSnapshot.child("carID").value.toString())
      .get();
  String colorString = carSnapshot.child("color").value.toString();
  if (colorString.contains("(")) {
    colorString = colorString.substring(
        colorString.indexOf("(") + 1, colorString.indexOf(")"));
  }
  print("CAR STRING IS $colorString");
  print("CAR ID IS ${dataSnapshot.child("carID").value.toString()}");
  Car car = Car(
    color: Color(int.parse(colorString)),
    noPlate: carSnapshot.child("plate").value.toString(),
    model: carSnapshot.child("model").value.toString(),
  );
  DataSnapshot userSnapshot = await dbRef
      .child("users")
      .child("clients")
      .child(dataSnapshot.child("userID").value.toString())
      .get();

  //custom drop off location
  CustomLocation? dropOffLocation;
  if (t == RequestType.TTA) {
    print("THIS IS A TTA AND THE DESTINATION IS");
    if (dataSnapshot.child("destination").value != null) {
      double lat = double.parse(
          (dataSnapshot.child("destination").child("latitude").value)
              .toString());
      double lon = double.parse(
          (dataSnapshot.child("destination").child("longitude").value)
              .toString());
      dropOffLocation = CustomLocation(latitude: lat, longitude: lon);
      print("_!? ${dropOffLocation.toString()}");
    }
  }

//get mechanic if there is
  String? mechanicID;
  Mechanic? mechanic;
  for (var response in dataSnapshot.child("mechanicsResponses").children) {
    if ((response.value == "accepted" &&
            RSA.stringToRequestType(requestType.toUpperCase()) ==
                RequestType.RSA) ||
        (response.value == "chosen" &&
            RSA.stringToRequestType(requestType.toUpperCase()) !=
                RequestType.RSA)) {
      mechanicID = response.key.toString();
    }
  }
  if (mechanicID != null) {
    //there is a mechanic and we have his id
    mechanic = await getMechanicData(mechanicID);
  }
  /////////////////////////
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
      latitude: double.parse(dataSnapshot.child("latitude").value.toString()),
      longitude: double.parse(dataSnapshot.child("longitude").value.toString()),
      // name: dataSnapshot.child("address").value.toString(),
    ),
    // report: Report()
    dropOffLocation: dropOffLocation,
    mechanic: mechanic,
  );
  rsaCache[rsa.rsaID!] = rsa;
  return rsa;
}

Future getMechanicData(String id) async {
  DataSnapshot ds = await dbRef.child("users").child(id).get();
  CustomLocation? workShop;
  if (ds.child("workshop").value != null) {
    double lat =
        double.parse((ds.child("workshop").child("latitude").value).toString());
    double lon = double.parse(
        (ds.child("workshop").child("longitude").value).toString());

    dynamic name = (ds.child("workshop").child("name").value);
    name = (name != null) ? name.toString() : null;

    dynamic address = (ds.child("workshop").child("address").value);
    address = (address != null) ? address.toString() : null;

    workShop = CustomLocation(
        latitude: lat, longitude: lon, name: name, address: address);
  }

  String address = "address";
  return Mechanic(
    phoneNumber: (ds.child("phoneNumber").value).toString(),
    id: id,
    name: (ds.child("name").value).toString(),
    email: (ds.child("email").value).toString(),
    address: address,
    loc: workShop,
  );
}
