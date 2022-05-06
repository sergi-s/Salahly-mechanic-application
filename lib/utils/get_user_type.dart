import 'package:shared_preferences/shared_preferences.dart';
import 'package:salahly_models/abstract_classes/user.dart';

Type? userType;

Future<Type?> getUserType() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userType = prefs.getString('userType');
  if (userType == 'mechanic') {
    return Type.mechanic;
  }else if (userType == 'client') {
    return Type.client;
  }else if (userType == 'provider') {
    return Type.provider;
  }
  return null;
}