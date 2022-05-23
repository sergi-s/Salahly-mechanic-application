import 'package:firebase_database/firebase_database.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_models/abstract_classes/user.dart';
import 'package:salahly_models/salahly_models.dart';
import 'package:string_validator/string_validator.dart';

Future getMechanicOrProviderData(String id) async {
  DataSnapshot ds = await dbRef.child("users").child(id).get();
  double? rating;
  if (ds.child("rating").value != null) {
    double count =
    toDouble((ds.child("rating").child("count").value).toString());
    if (count == 0) count = 1;
    rating =
        toDouble((ds.child("rating").child("sum").value).toString()) / count;
  }
  if (ds.child("type").value.toString() == "mechanic") {
    return Mechanic(
        isCenter: false,
        avatar: "",
        phoneNumber: (ds.child("phoneNumber").value).toString(),
        id: id,
        name: (ds.child("name").value).toString(),
        type: Type.mechanic,
        email: (ds.child("email").value).toString(),
        rating: rating,
        address: "address");
  } else {
    return TowProvider(
        isCenter: ((ds.child("isCenter").value).toString()) == "true",
        avatar: ((ds.child("avatar").value).toString()),
        phoneNumber: (ds.child("phoneNumber").value).toString(),
        id: id,
        type: Type.provider,
        name: (ds.child("name").value).toString(),
        email: (ds.child("email").value).toString(),
        rating: rating,
        loc: CustomLocation(
          latitude:
              toDouble(ds.child('workshop').child('latitude').value.toString()),
          longitude: toDouble(ds.child('workshop').child('longitude').value.toString()),
          name: ds.child('workshop').child('name').value.toString(),
          address: ds.child('workshop').child('address').value.toString(),
        ),
        address: "address");
  }
}
