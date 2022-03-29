import 'dart:async';
import 'package:flutter_geofire/flutter_geofire.dart';
import '../../main.dart';

class CustomLocation {
  late double longitude;
  late double latitude;
  late String? address;
  late String? name;


  CustomLocation({required this.latitude, required this.longitude, this.address, this.name});
}

class NearbyLocations {

  static addNearbyMechanicsAndProviders() async {
    _initializeGeoFireOnAvailable();
    CustomLocation loc_1 = CustomLocation(
      latitude: 35.207877,
      longitude: 28.918180,
      name: "mego",
      // name: "mech 1",
    );
    CustomLocation loc_2 = CustomLocation(
      latitude: 33.207545,
      longitude: 20.919915,
      name: "meca",
      // name: "mech 2",
    );
    CustomLocation loc_3 = CustomLocation(
      latitude: 32.206866,
      longitude: 24.918298,
      name: "mogo",
    );
    var locs = [loc_1, loc_2, loc_3];
    //31.207545, 29.919915
    for (CustomLocation lolo in locs) {
      await _addLocToDB(lolo);
    }
  }

  static _addLocToDB(CustomLocation lola) async {
    // await dbRef.child("available").child((lola.name).toString()).set({
    //
    // });
    return (await Geofire.setLocation(
        lola.name.toString(), lola.latitude, lola.longitude));
  }

  static _initializeGeoFireOnAvailable() async {
    String pathToReference = "available";
    // String pathToReference = "availableProviders";
    pathToReference = dbRef
        .child(pathToReference)
        .path;
    await Geofire.initialize(pathToReference);
  }

  static _deleteLocToDB(CustomLocation yoyo) async {
    return (await Geofire.removeLocation(
        yoyo.name.toString()));
  }

  static deleteNearbyMechanicsAndProviders() async {
    _initializeGeoFireOnAvailable();
    CustomLocation loc_1 = CustomLocation(
      latitude: 35.207877,
      longitude: 28.918180,
      name: "mego",
      // name: "mech 1",
    );
    CustomLocation loc_2 = CustomLocation(
      latitude: 33.207545,
      longitude: 20.919915,
      name: "meca",
      // name: "mech 2",
    );
    CustomLocation loc_3 = CustomLocation(
      latitude: 32.206866,
      longitude: 24.918298,
      name: "mogo",
    );
    var locs = [loc_1, loc_2, loc_3];
    //31.207545, 29.919915
    for (CustomLocation lolo in locs) {
      await _deleteLocToDB(lolo);
    }
  }
}