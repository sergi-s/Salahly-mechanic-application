import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salahly_mechanic/abstract_classes/authentication.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/screens/Requests/allscreens.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_models/models/client.dart' as Models;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/utils/constants.dart';
import 'package:salahly_models/models/report.dart' as Rep;
import 'package:shared_preferences/shared_preferences.dart';
class FirebaseCustom extends Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<bool> login(String email, String password) async {
    try {
      String emm = ((email) != null ? email : "").toString();
      final user = await _firebaseAuth.signInWithEmailAndPassword(
          email: emm, password: password);
      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await dbRef.child("users").child(user.user!.uid).get().then((snapshot) async {
          if(snapshot.value != null) {
            prefs.setString("userType", snapshot.child("type").value.toString());
            userType = await getUserType();
          }
        });
        await _registerFCMToken(FirebaseAuth.instance.currentUser!.uid);
        _registerNotifications();
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
    return false;
  }

  _registerFCMToken(String id) async {
    return await FirebaseMessaging.instance
        .getToken()
        .then((value) => dbRef.child("FCMTokens").child(id).set(value));
    // .then((value) => dbRef.child("FCMTokens").set({id: value}));
  }

  Future<void> _onBackgroundMessage(RemoteMessage message) async {
    print('>>> onBackgroundMessage');

    if (message.data["request_type"] == "rsa" ||
        message.data["request_type"] == "wsa") {}
    if (navigatorKey.currentState != null) {
      print('>>> opened screen');
      navigatorKey.currentState?.pushNamed(PendingRequests.routeName);
    } else
      print('>>> navigatorkey state is null');
  }

  _registerNotifications() {
    FirebaseMessaging.instance.onTokenRefresh.listen((event) async {
      await _registerFCMToken(FirebaseAuth.instance.currentUser!.uid);
    });
    // FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage); TODO sh8alha tani
    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      print("message received");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) async {
      print("message opened");
      print(event.data);
    });

    // final prefs = await SharedPreferences.getInstance();
    // FirebaseMessaging.onMessage.listen((RemoteMessage event) async{
    //   print("message recieved");
    //   print(event.notification!.body);
    //
    //   showSimpleNotification(Text("Received a notification, rsaID: "+event.notification!.body.toString()),
    //       background: Colors.green);
    //   await prefs.setString("rsaID", event.notification!.body.toString());
    //   print("RSA ID: "+ event.notification!.body.toString());
    // });
    // FirebaseMessaging.onMessageOpenedApp.listen((message) {
    //   print('Message clicked!');
    // });
  }

  @override
  Future<bool> signup(String email, String password) async {
    String emm = ((email) != null ? email : "").toString();
    final User? firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(email: emm, password: password)
            .catchError((errMsg) {
      print(errMsg);
      return false;
    }))
        .user;

    if (firebaseUser != null) {
      await _registerFCMToken(FirebaseAuth.instance.currentUser!.uid);
      _registerNotifications();
      return true;
      //user created
      // Map userDataMap = {
      //   "name": client.name,
      //   "email": client.email,
      //   "birthday": client.birthDay,
      //   "createdDate": client.createdDate,
      //   "sex": client.sex,
      //   "type": client.type,
      //   "avatar": client.avatar,
      //   "address": client.address,
      //   "phoneNumber": client.phoneNumber,
      //   "loc": client.loc
    }
    ;
    // usersRef.child(firebaseUser.uid).set(userDataMap);
    return false;
  }

  Future<bool> registration(Models.Client client) async {
    final User? user = _firebaseAuth.currentUser;
    if (user == null) {
      return false;
    }
    final uid = user.uid;
    Map userDataMap = {
      "name": client.name,
      "email": client.email,
      // "birthday": client.birthDay,
      // "sex": client.sex,
      // "avatar": client.avatar,
      "address": client.address,
      "phoneNumber": client.phoneNumber,
      "isCenter": false,
      "rating": 3.4,
      "type": "mechanic"
    };
    usersRef.child(uid).set(userDataMap);
    return true;
  }

  final bool use_emulator = true;

  Future _connectToFirebaseEmulator() async {
    final _localHostString = localHostString;
    FirebaseDatabase.instance.useDatabaseEmulator(_localHostString, fbdbport);
    await FirebaseAuth.instance.useAuthEmulator(_localHostString, fbauthport);
    print("Connected to emulator");
  }

  Future connectToEmulator() async {
    if (use_emulator) {
      try {
        await _connectToFirebaseEmulator();
      } catch (Exception) {
        print(Exception);
      }
    } else
      print("Not using emulator");
  }
  Future<bool> report(Rep.Report report, String rsaID ,String requestType) async {
    Map reportDataMap = {
      "carType" :report.carType,
      "actualdistance": report.actualDistance,
      "systemname": report.systemName,
      "maintancecost": report.maintenanceCost,
      "maintancedescription": report.maintenanceDescription,
      "othercost": report.otherCost,
      "partcost": report.partCost,
      "partname": report.partName,
      "partid": report.partID,
      "distance": report.distance,

    };
    dbRef.child("wsa").child(rsaID).child("report").set(reportDataMap);
    return true;
  }
}
