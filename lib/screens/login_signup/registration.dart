import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/firebase/firebase.dart';
import 'package:salahly_mechanic/screens/Requests/allscreens.dart';
import 'package:salahly_mechanic/screens/login_signup/text_input.dart';
import 'package:salahly_mechanic/widgets/login_signup/Rounded_Bottom.dart';
import 'package:salahly_models/models/client.dart' as Client;

import '../../widget/profile_widget.dart';
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
  // Validator validation = Validator();
  FirebaseCustom fb = FirebaseCustom();

  //late TextEditingController emailController = TextEditingController();
  String username = "";
  DateTime? _selectedDate ;
  String phonenumber = "";

  String address = "";

  String age = "";

  // String gender = "";
  updateusername(String u) {
    username = u;
  }

  updatephonenumber(String pn) {
    phonenumber = pn;
  }

  updateaddress(String adr) {
    address = adr;
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
        name: username,
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
            'assets/images/logo white.png',
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
              ProfileWidget(
                imagePath: "assets/images/user.png",
                onClicked: () async {},
              ),
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
              MyInput(
                hint:  _selectedDate != null? DateFormat.yMMMEd().format(_selectedDate!) : 'Birthdate',
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
                  onPressed: () {
                    _datePicker(context);
                  },
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
              SelectTextField(
                hintText: 'WorkShop Type',
                items: ["Center", "WorkShop"],
                onChangedfunction: () {},
              ),

              //Registration_Input(hintText: 'Age', icon: Icons.date_range,fn:updateage),
              //DatePicker(hintText: "Birthdate", icon:Icons.date_range, fn: updateage),
              // Registration_Input(hintText: 'Gender', icon: Icons.transgender,fn: updategender,),
              SizedBox(
                height: size.height * 0.05,
              ),
              SizedBox(
                width: size.width * 0.4,
                height:  size.height * 0.06,
                child: RaisedButton(
                  color: Color(0xFF193566),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: () {

                  },
                  child: Text(
                    "Register".tr(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              // RoundedButton(
              //   title: "Register",
              //   onPressedFunction: () async {
              //     registerOnPress(context);
              //   },
              // )
            ],
          ),
        ),
      ),
    );
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
