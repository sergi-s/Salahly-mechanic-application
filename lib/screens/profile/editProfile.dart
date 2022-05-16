import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salahly_mechanic/widgets/add_Schedular/select_textfield.dart';

// import '../../classes/provider/user_data.dart';
import '../../main.dart';
import '../../widgets/add_Schedular/text_input.dart';

class EditProfile extends ConsumerStatefulWidget {
  static const String routeName = "/editprofile";

  @override
  _State createState() => _State();
}

class _State extends ConsumerState<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  final TextEditingController emailyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DatabaseReference user = dbRef.child("users");
  File? _image;
  String? phone, address, email, name, data;
  File? url;
  dynamic path;
  String? emaily;
  String? passwordy;

  @override
  Widget build(BuildContext context) {
    // String? avatary = ref.watch(userProvider).avatar;
    // File? stateimage = File(avatary!);
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
            "Edit Profile",
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
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                // color: Colors.blue,
                child: Stack(
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
                            chooseImage();
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
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFd3dae4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(3, 0),
                  ),
                ]),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    MyInputField(
                      fn: () {},
                      title: 'Name',
                      controller: nameController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
                    ),
                    MyInputField(
                      fn: () {},
                      title: 'Email',
                      controller: emailyController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
                    ),
                    MyInputField(
                      fn: () {},
                      title: 'Phone',
                      controller: phoneController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
                    ),
                    MyInputField(
                      fn: () {},
                      title: 'Address',
                      controller: addressController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
                      widget: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.pin_drop,
                          color: Color(0xFF193566),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    SelectRequest(
                      onChangedfunction: () {},
                      title: 'Working In',
                      hintText: '',
                      items: ["WorkShop", "Center"],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RaisedButton(
                          splashColor: Colors.white.withAlpha(40),
                          color: Colors.white,
                          onPressed: () {
                            context.pop();
                          },
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          highlightElevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Color(0xFF193566)),
                          ),
                        ),
                        RaisedButton(
                          splashColor: Colors.white.withAlpha(40),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Text(
                                        "are you sure u want to update profile?"),
                                    title: Text("Confirmation"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Cancel")),
                                      TextButton(
                                          onPressed: () {
                                            final snackBar = SnackBar(
                                                content:
                                                    Text('profile updated'));
                                            updateProfile(context);
                                            updateAuth();
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          },
                                          child: Text("Confirm")),
                                    ],
                                  );
                                });
                          },
                          color: Color(0xFF193566),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFd3dae4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey,
                    blurRadius: 2.0,
                    spreadRadius: 0.0,
                    offset: Offset(3, 0),
                  ),
                ]),
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.01,
                    // ),

                    //   controller: passwordController,
                    //                       validator: (validator) {
                    //                         if (validator!.isEmpty) return 'Empty';
                    //                         return null;
                    //                       },
                    MyInputField(
                      fn: () {},
                      hint: '',
                      title: 'Password',
                    controller: passwordController,

                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    MyInputField(
                      fn: () {},
                      hint: '',
                      title: 'Confirm Password',
                      controller: confirmPassController,

                    ),
                    // controller: confirmPassController,
                    // validator: (validator) {
                    //   if (validator!.isEmpty) return 'Empty';
                    //   if (validator != passwordController.text)
                    //     return 'The passwords do not match';
                    //   return null;
                    // },

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    RaisedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(
                                    "are you sure u want to update password?"),
                                title: Text("Warning"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        final snackBar = SnackBar(
                                            content: Text('Password updated'));
                                        final snackBar2 = SnackBar(
                                            content: Text('invalid password'));
                                        if (passwordController.text ==
                                                confirmPassController.text &&
                                            passwordController.text.length >=
                                                6) {
                                          updateAuth();
                                          Navigator.of(context).pop();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar2);
                                        }
                                      },
                                      child: Text("Confirm")),
                                ],
                              );
                            });
                      },
                      color: Color(0xFF193566),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "update password",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.018,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
        ],
      ),
    );
  }

  chooseImage() async {
    //open gallery to upload image
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("filattoooo" + image!.path);
    setState(() {
      _image = File(image.path);
    });
    print(_image);
  }

  updateAuth() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    emaily = firebaseUser?.email;
    // EmailAuthProvider.credential(email: emaily!, password: '');

    // emailyController.text.isNotEmpty
    //     ? firebaseUser?.updateEmail(emailyController.text)
    //     : null;
    //
    // nameController.text.isNotEmpty
    //     ? firebaseUser?.updateDisplayName(nameController.text)
    //     : null;
    print("b4");
    if (await firebaseUser != null) {
      firebaseUser?.updateEmail(emailyController.text);
      firebaseUser?.updateDisplayName(nameController.text);
      firebaseUser?.updatePassword(passwordController.text);
      // signed in
    } else {}

    print("updated");
  }

  updateProfile(BuildContext context) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> map = {};
    //
    // map['name'] = nameController.text.isEmpty
    //     ? ref.watch(userProvider).name
    //     : nameController.text;
    //
    // map['address'] = addressController.text.isEmpty
    //     ? ref.watch(userProvider).address
    //     : addressController.text;
    //
    // map['phoneNumber'] = phoneController.text.isEmpty
    //     ? ref.watch(userProvider).phoneNumber
    //     : phoneController.text;
    //
    // map['email'] = emailyController.text.isEmpty
    //     ? ref.watch(userProvider).email
    //     : emailyController.text;

    user
        .child("clients")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .update(map);
    fetch();
  }

  Future<String> uploadImage(BuildContext context) async {
    final snackBar = SnackBar(content: Text('Are you talkin\' to me?'));

    // String filepath = basename(file.path);
    //add image into fireStorage
    // final storage = await FirebaseStorage.instance.ref()
    //   ..child("users").child("profile_picture").child(
    //       FirebaseAuth.instance.currentUser!.uid +
    //           "_" +
    //           basename(_image!.path));
    // print("storage");
    // dynamic store = await storage.root;
    // print(store.toString());
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("users")
        .child("profile_picture")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .putFile(_image!);
    // TaskSnapshot snapshot = await FirebaseStorage.instance
    //     .ref()
    //     .child("users")
    //     .child("profile_picture")
    //     .child(FirebaseAuth.instance.currentUser!.uid +
    //         "_" +
    //         basename(_image!.path))
    //     .writeToFile(_image!);

    //get image for current user from fireStorage
    dynamic url = await taskSnapshot.ref.getDownloadURL();

    // ref.watch(userProvider.notifier).assignAvatar(url);

    //RTDB
    user
        .child("clients")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .update({'image': url});
    print("reading");
    print(url.toString());
    // print("ahoo");
    // print(url.toString());

    return url;
  }

  fetch() async {
    final firebaseuser = await FirebaseAuth.instance.currentUser;
    user
        .child("clients")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .once()
        .then((event) {
      final dataSnapshot = event.snapshot;
      print("read" + dataSnapshot.value.toString());
      var data = dataSnapshot.value as Map;
      setState(() {
        if (data != null) {
          email = data["email"];
          name = data["name"];
          phone = data["phoneNumber"];
          path = data["image"];
          address = data["address"];
          // ref.watch(userProvider.notifier).assignEmail(email!);
          // ref.watch(userProvider.notifier).assignName(name!);
          // ref.watch(userProvider.notifier).assignPhoneNumber(phone!);
          // ref.watch(userProvider.notifier).assignAvatar(path);
          // ref.watch(userProvider.notifier).assignAddress(address!);
        }
      });
    });
    print("here");
    print(path);
    print(firebaseuser!.email);
    print(firebaseuser.displayName);
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
