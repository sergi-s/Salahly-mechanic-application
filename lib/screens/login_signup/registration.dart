import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:salahly_mechanic/classes/firebase/firebase.dart';
import 'package:salahly_mechanic/screens/Requests/allscreens.dart';
import 'package:salahly_mechanic/screens/login_signup/text_input.dart';
import 'package:salahly_mechanic/widgets/login_signup/userImage.dart';
import 'package:salahly_models/models/client.dart' as Client;
import 'package:salahly_models/models/location.dart';

import '../../utils/location/geocoding.dart';
import '../../utils/location/getuserlocation.dart';
import '../../widgets/login_signup/roundedInput.dart';
import '../../widgets/report/select_button.dart';

class Registration extends StatefulWidget {
  static final routeName = "/registrationscreen";

  Registration({
    Key? key,
    required this.emailobj,
  }) : super(key: key);
  final String emailobj;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  FirebaseCustom fb = FirebaseCustom();
  DateTime? _selectedDate;
  String name = "";
  String phonenumber = "";
  String address = "";
  String userType = "";
  String workType = "";
  String imageUrl = "";
  String _verticalGroupValue = "";

  List<String> _status = ["Female", "Male"];
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  static const double initialCameraZoom = 15;
  double cameraZoom = 14;

  // Current Location
  // late Position currentPos;
  late LatLng currentPos;
  late CustomLocation currentCustomLoc;

  Geolocator geoLocator = Geolocator();

  //initial Camera position
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: initialCameraZoom,
  );

  //Markers
  List<Marker> myMarkers = [];

  @override
  void initState() {
    initialLocation();
    locatePosition();
    super.initState();
  }

  // String gender = "";
  updateusername(String u) {
    name = u;
  }

  updatephonenumber(String pn) {
    phonenumber = pn;
  }

  updateaddress(String adr) {
    address = adr;
  }

  updateuserType(String usertype) {
    userType = usertype;
  }

  updateworkType(String worktype) {
    workType = worktype;
  }

  // updateage(String age) {
  registerOnPress(BuildContext context) async {
    // if (!Validator.usernameValidator(username)) {
    //   return ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content: Text('Invalid username!! Please try again')));
    // }
    // if (!Validator.phoneValidator(phonenumber)) {
    //   return ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content: Text('Invalid phonenumber!! Please try again')));
    // }
    // if (!Validator.ageValidator(age)) {
    //   return ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(
    //           content:
    //           Text('Invalid age!! Please try again')));
    // }

    Client.Client client = Client.Client(
        name: name,
        email: widget.emailobj,
        address: address,
        phoneNumber: phonenumber,
        subscription: Client.SubscriptionTypes.silver);

    bool check = await fb.registration(client);
    if (check) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(' Sucessfull ')));
      context.go(OngoingScreenDummy.routeName);
    } else {
      return ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Failed to Register!!')));
    }
  }

  _datePicker(BuildContext context) async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color(0xFFd1d9e6),
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: const Color(0xFFd1d9e6),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0xFF193566),
            ),
            onPressed: () {},
          ),
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(""),
            Text(
              "Registration".tr(),
              style: TextStyle(
                fontSize: 22,
                letterSpacing: 1,
                color: Color(0xFF193566),
                fontWeight: FontWeight.w600,
              ),
            ),
            Image.asset(
              'assets/images/logodark.png',
              fit: BoxFit.contain,
              height: 32,
            ),
          ]),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  // ProfileWidget(
                  //   imagePath: "assets/images/user.png",
                  //   onClicked: () async {
                  //     _SelectPhoto();
                  //   },
                  // ),
                  Stack(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Color(0xFF193566),
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10),
                              ),
                            ],
                            shape: BoxShape.circle,
                            // image: DecorationImage(
                            //     fit: BoxFit.cover, image: FileImage(_image!))),
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                            // (_image != null)
                            //     ? FileImage(_image!) as ImageProvider
                            //     :
                            AssetImage(
                              // ref.watch(userProvider).avatar ??
                                "assets/images/user.png"),
                          ),
                        ),
                        onTap: () {},
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(width: 1, color: Colors.white),
                              color: Color(0xFF193566)),
                          child: GestureDetector(
                            onTap: () {
                              // chooseImage();
                              // final snackBar =
                              //     SnackBar(content: Text('Image uploaded'));
                              //
                              // try {
                              //   uploadImage(context);
                              //   ScaffoldMessenger.of(context)
                              //       .showMaterialBanner(MaterialBanner(
                              //     content:
                              //         const Text('Image updated Successfully'),
                              //     actions: [
                              //       TextButton(
                              //           onPressed: () {
                              //             ScaffoldMessenger.of(context)
                              //                 .hideCurrentMaterialBanner();
                              //           },
                              //           child: const Text('Dismiss')),
                              //     ],
                              //   ));
                              //   // ScaffoldMessenger.of(context)
                              //   //     .showSnackBar(snackBar);
                              // } catch (e) {}
                            },
                            child: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // UserImage(onFilechanged: (imageUrl) {
                  //   setState(() {
                  //     this.imageUrl = imageUrl;
                  //   });
                  // }),

                  // GoogleMap(
                  //     mapType: MapType.normal,
                  //     myLocationButtonEnabled: true,
                  //     // myLocationEnabled: true,
                  //     zoomGesturesEnabled: true,
                  //     zoomControlsEnabled: false,
                  //     initialCameraPosition: _kGooglePlex,
                  //     onMapCreated: (GoogleMapController controller) {
                  //       _controllerGoogleMap.complete(controller);
                  //       newGoogleMapController = controller;
                  //     },
                  //     markers: Set.from(myMarkers),
                  //     onTap: _handleTap),

                  // SizedBox(height:180),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  RounedInput(
                    icon: Icons.face,
                    fn: () {},
                    hint: 'Name',
                  ),
                  RounedInput(
                    icon: Icons.phone,
                    fn: () {},
                    hint: 'Phone',
                  ),
                  RounedInput(
                    icon: Icons.business_rounded,
                    fn: () {},
                    hint: 'Shop Name',
                  ),
                  MyInput(
                    hint: _selectedDate != null
                        ? DateFormat.yMMMEd().format(_selectedDate!)
                        : 'Birthdate',
                    fn: () {},
                    widget: IconButton(
                      onPressed: () {
                        _datePicker(context);
                      },
                      icon: const Icon(
                        Icons.calendar_today,
                        color: Color(0xFF193566),
                      ),
                    ),
                  ),
                  MyInput(
                    hint: "Address",
                    fn: () {},
                    widget: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.pin_drop,
                        color: Color(0xFF193566),
                      ),
                    ),
                  ),
                  SelectTextField(
                    hintText: 'User Type',
                    items: ["Mechanic", "Provider"],
                    onChangedfunction: () {},
                  ),
                  if (workType != null)
                    SelectTextField(
                      hintText: 'WorkShop Type',
                      items: ["Center", "WorkShop"],
                      onChangedfunction: () {},
                    ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: size.width * 0.15,
                          ),
                          Text(
                            "Gender",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF193566)),
                          ),
                        ],
                      ),
                      RadioGroup<String>.builder(
                        direction: Axis.horizontal,
                        groupValue: _verticalGroupValue,
                        horizontalAlignment: MainAxisAlignment.spaceAround,
                        onChanged: (value) => setState(() {
                          _verticalGroupValue = value as String;
                        }),
                        items: _status,
                        textStyle:
                            TextStyle(fontSize: 15, color: Color(0xFF193566)),
                        itemBuilder: (item) => RadioButtonBuilder(
                          item,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  SizedBox(
                    width: size.width * 0.4,
                    height: size.height * 0.06,
                    child: RaisedButton(
                      color: Color(0xFF193566),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Register".tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  //Registration_Input(hintText: 'Age', icon: Icons.date_range,fn:updateage),
                  //DatePicker(hintText: "Birthdate", icon:Icons.date_range, fn: updateage),

                  // RoundedButton(
                  //   title: "Register",
                  //   onPressedFunction: () async {
                  //     registerOnPress(context);
                  //   },
                  // )
                ]),
          ),
        ));
  }

  locatePosition() async {
    currentCustomLoc = await getUserLocation();
    cameraZoom = 19;
    moveCamera(currentCustomLoc);
  }

  //move camera to current position
  moveCamera(CustomLocation cus) async {
    currentCustomLoc = cus;
    currentCustomLoc.address = await searchCoordinateAddress_google(
        currentCustomLoc.latitude, currentCustomLoc.longitude);

    LatLng latLatPosition =
        LatLng(currentCustomLoc.latitude, currentCustomLoc.longitude);

    setState(() {
      myMarkers = [];
      myMarkers.add(
        Marker(
            markerId: MarkerId(latLatPosition.toString()),
            position: latLatPosition),
      );
    });

    CameraPosition camPos =
        CameraPosition(target: latLatPosition, zoom: cameraZoom);
    newGoogleMapController
        .animateCamera(CameraUpdate.newCameraPosition(camPos));
  }

  //put a marker on pressed on map
  _handleTap(LatLng tappedPoint) {
    setState(() {
      cameraZoom = 19;
      moveCamera(CustomLocation(
          latitude: tappedPoint.latitude, longitude: tappedPoint.longitude));
      myMarkers = [];
      myMarkers.add(
        Marker(
            draggable: true,
            markerId: MarkerId(tappedPoint.toString()),
            position: tappedPoint,
            onDragEnd: (dragEndPosition) {
              moveCamera(CustomLocation(
                  latitude: dragEndPosition.latitude,
                  longitude: dragEndPosition.longitude));
            }),
      );
    });
  }

  //get approximate location of user
  initialLocation() async {
    List temp = await getApproximateLocation();
    CustomLocation initialPos =
        CustomLocation(latitude: temp[0], longitude: temp[1]);

    moveCamera(initialPos);
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xFF193566);
    Path path = Path()
      ..relativeLineTo(0, 90)
      ..quadraticBezierTo(size.width / 2, 150, size.width, 90)
      ..relativeLineTo(0, -90)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
