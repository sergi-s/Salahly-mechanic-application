import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:salahly_mechanic/utils/location/getuserlocation.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_models/models/location.dart';

class NearbyLocations {

  static setAvailabilityOn() async {
    _initializeGeoFireOnAvailable();
    // CustomLocation loc_1 = await getUserLocation();
    DatabaseReference workshopLocaiton = dbRef.child("users").child(FirebaseAuth.instance.currentUser!.uid).child("workshop");
    print("Data: "+(await workshopLocaiton.get()).value.toString());
    double longitude = (await workshopLocaiton.child("longitude").get()).value as double;
    double latitude = (await workshopLocaiton.child("latitude").get()).value as double;
    CustomLocation loc_1 = CustomLocation(longitude: longitude, latitude: latitude);
    loc_1 = CustomLocation(latitude: loc_1.latitude, longitude: loc_1.longitude, name: FirebaseAuth.instance.currentUser!.uid);
    //31.207545, 29.919915
    return await _addLocToDB(loc_1);
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

  static _deleteLocToDB(String id) async {
    return (await Geofire.removeLocation(
        id));
  }

  static setAvailabilityOff() async {
    _initializeGeoFireOnAvailable();
    return await _deleteLocToDB(FirebaseAuth.instance.currentUser!.uid);
  }
}