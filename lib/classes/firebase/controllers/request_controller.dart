import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_mechanic/utils/location/geocoding.dart';
import 'package:salahly_mechanic/utils/requests_memory_caching.dart';
import 'package:salahly_models/abstract_classes/user.dart';
import 'package:salahly_models/models/car.dart';
import 'package:salahly_models/models/client.dart';
import 'package:salahly_models/models/location.dart';
import 'package:salahly_models/models/mechanic.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

Future<RSA?> loadRequestFromDB(String id, String requestType) async {
  DataSnapshot dataSnapshot = await dbRef.child(requestType).child(id).get();
  if (dataSnapshot.value == null) return null;

  RequestType t = RSA.stringToRequestType(requestType.toUpperCase())!;

  // Get the car of this request   MANDATORY
  Car? car;
  if (dataSnapshot.child("carID").value != null) {
    DataSnapshot carSnapshot = await dbRef
        .child("cars")
        .child(dataSnapshot.child("carID").value.toString())
        .get();
        if(carSnapshot.value != null) {

    String colorString = carSnapshot.child("color").value.toString();
    if (colorString.contains("(")) {
      colorString = colorString.substring(
          colorString.indexOf("(") + 1, colorString.indexOf(")"));
    }
    // print("CAR STRING IS $colorString");
    // print("CAR ID IS ${dataSnapshot.child("carID").value.toString()}");
    car = Car(
      color: Color(int.parse(colorString)),
      noPlate: carSnapshot.child("plate").value.toString(),
      model: carSnapshot.child("model").value.toString(),
    );
        }
  } else {
    return null;
  }

  // get Client of this request   MANDATORY
  DataSnapshot userSnapshot = await dbRef
      .child("users")
      .child("clients")
      .child(dataSnapshot.child("userID").value.toString())
      .get();
  Client? _user;
  if (userSnapshot.value != null) {
    _user = Client(
      name: userSnapshot.child("name").value.toString(),
      phoneNumber: userSnapshot.child("phoneNumber").value.toString(),
    );
  } else {
    return null;
  }

  // If user is provider
  Mechanic? acceptedMechanic;
  CustomLocation? dropOffLocationTTA;
  if (await getUserType() == Type.provider) {
    //custom drop off location
    if (RSA.stringToRequestType(requestType.toUpperCase()) == RequestType.TTA) {
    } else {
      //get mechanic if there is one
      String? mechanicId;
      // Request is RSA or WSA and we need to get mechanic's data
      for (var response in dataSnapshot.child("mechanicsResponses").children) {
        if ((response.value == "accepted" &&
                RSA.stringToRequestType(requestType.toUpperCase()) ==
                    RequestType.RSA) ||
            (response.value == "chosen" &&
                RSA.stringToRequestType(requestType.toUpperCase()) !=
                    RequestType.RSA)) {
          mechanicId = response.key.toString();
          break;
        }
      }
      if (mechanicId != null) {
        //there is a mechanic and we have his id
        acceptedMechanic = await getMechanicData(mechanicId);
      }
    }
  }

  double lat = double.parse(dataSnapshot.child("latitude").value.toString());
  double lng = double.parse(dataSnapshot.child("longitude").value.toString());
  String locationName = (await searchCoordinateAddressGoogle(lat: lat, long: lng)).toString();

  RSA rsa = RSA(
    user: _user,
    // MUST
    car: car,
    // MUST
    state: RSA.stringToState(dataSnapshot.child("state").value.toString()),
    // MUST
    rsaID: dataSnapshot.key.toString(),
    // MUST
    requestType: t,
    // MUST
    location: CustomLocation(
      // MUST
      name: locationName,
      latitude: lat,
      longitude: lng,
      // name: dataSnapshot.child("address").value.toString(),
    ),
    // report: Report()
    dropOffLocation: dropOffLocationTTA,
    // OPTIONAL
    mechanic: acceptedMechanic, // OPTIONAL
  );
  rsaCache[rsa.rsaID!] = rsa;
  return rsa;
}

CustomLocation? getDropOffLocation(DataSnapshot dataSnapshot) {
  CustomLocation? dropOffLocation;

  if (dataSnapshot.child("destination").value != null) {
    double lat = double.parse(
        (dataSnapshot.child("destination").child("latitude").value).toString());
    double lon = double.parse(
        (dataSnapshot.child("destination").child("longitude").value)
            .toString());
    dropOffLocation = CustomLocation(latitude: lat, longitude: lon);
  }

  return dropOffLocation;
}

Future getMechanicData(String id) async {
  DataSnapshot ds = await dbRef.child("users").child(id).get();
  CustomLocation? workShop;

  if (ds.value != null && ds.child("workshop").value != null) {
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

    return Mechanic(
      phoneNumber: (ds.child("phoneNumber").value).toString(),
      id: id,
      name: (ds.child("name").value).toString(),
      email: (ds.child("email").value).toString(),
      loc: workShop,
    );
  }
  return;
}