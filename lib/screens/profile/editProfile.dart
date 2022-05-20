import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_mechanic/utils/location/geocoding.dart';
import 'package:salahly_mechanic/widgets/add_Schedular/select_textfield.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_models/abstract_classes/user.dart';
import 'package:salahly_models/models/location.dart';
import 'package:path/path.dart' as p;
import '../../main.dart';
import '../../widgets/add_Schedular/text_input.dart';

class EditProfile extends ConsumerStatefulWidget {

  static const String routeName = "/edit_profile";
  dynamic user;

  EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends ConsumerState<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController emailyController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  DatabaseReference user = dbRef.child("users");
  File? _image;
  String _imagePath = '';
  String? phone, address, email, name, data;
  File? url;
  dynamic path;
  String? emaily;
  String? passwordy;
  Type? type;

  bool changedEmail = false,
      changedPassword = false,
      changedPhone = false,
      changedAddress = false,
      changedName = false,
      changedWorkshopType = false,
      isCenter = false,
      changedWorkshopName = false;

  CustomLocation? location;

  @override
  void initState() {
    getUserType().then((value) => setState(() {
          type = value;
        }));
    nameController.text = widget.user.name != null ? widget.user.name! : "";
    emailyController.text = widget.user.email != null ? widget.user.email! : "";
    phoneController.text =
        widget.user.phoneNumber != null ? widget.user.phoneNumber! : "";
    shopNameController.text =
        widget.user.loc != null && widget.user.loc!.name != null
            ? widget.user.loc!.name!
            : "";
    addressController.text =
        widget.user.loc != null && widget.user.loc!.address != null
            ? widget.user.loc!.address!
            : "";
    isCenter = widget.user.isCenter != null
        ? widget.user.isCenter!
            ? true
            : false
        : false;
    _image = widget.user.avatar != null ? File(widget.user.avatar!) : null;
    _imagePath = widget.user.avatar != null ? widget.user.avatar! : null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String? avatary = ref.watch(userProvider).avatar;
    // File? stateimage = File(avatary!);
    return Scaffold(
      backgroundColor: const Color(0xFFd1d9e6),
      appBar: salahlyAppBar(context, title: 'edit_profile'.tr())
      /*AppBar(
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
      )*/
      ,
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
                        child: CachedNetworkImage(
                          imageUrl: _imagePath,
                          width: 128,
                          height: 128,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Icon(Icons.error),

                        ),
                        // child: CircleAvatar(
                        //   backgroundImage: (_image != null)
                        //       ? FileImage(_image!) as ImageProvider
                        //       : AssetImage(
                        //           // ref.watch(userProvider).avatar ??
                        //           "assets/images/user.png"),
                        // ),
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
                            color: const Color(0xFF193566)),
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
                      fn: (value) {
                        changedName = true;
                        name = value;
                      },
                      title: 'Name',
                      controller: nameController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
                    ),
                    MyInputField(
                      fn: (value) {
                        changedEmail = true;
                      },
                      title: 'Email',
                      controller: emailyController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
                    ),
                    MyInputField(
                      fn: (value) {
                        changedPhone = true;
                      },
                      title: 'Phone',
                      controller: phoneController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
                    ),
                    MyInputField(
                      fn: (value) {
                        changedAddress = true;
                      },
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
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    type == Type.mechanic
                        ? SelectRequest(
                            onChangedfunction: (value) {
                              changedWorkshopType = true;
                              isCenter = value;
                            },
                            title: 'Working In',
                            hintText: widget.user.isCenter != null
                                ? widget.user.isCenter!
                                    ? "center".tr()
                                    : "workShop".tr()
                                : '',
                            items: const ["WorkShop", "Center"],
                          )
                        : Container(),
                    MyInputField(
                      fn: (value) {
                        changedWorkshopName = true;
                      },
                      title: 'shop_name'.tr(),
                      controller: shopNameController,
                      hint: "",
                      // ref.watch(userProvider).email ?? "wait",
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
                                            Navigator.of(context).pop();
                                            final snackBar = SnackBar(
                                                content:
                                                    Text('profile updated'));
                                            updateProfile(context);
                                            // updateAuth();
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
                    MyPasswordInputField(
                      fn: (a) {},
                      hint: '',
                      title: 'old_password'.tr(),
                      controller: oldPasswordController,
                    ),
                    MyPasswordInputField(
                      fn: (v) {
                        changedPassword = true;
                      },
                      hint: '',
                      title: 'new_assword'.tr(),
                      controller: passwordController,
                    ),
                    // SizedBox(
                    //   height: 20,
                    // ),
                    MyPasswordInputField(
                      fn: (a) {},
                      hint: '',
                      title: 'confirm_password'.tr(),
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
                                        Navigator.of(context).pop();
                                        final snackBar3 = SnackBar(
                                            content: Text(
                                                'old_password_invalid'.tr()));
                                        final snackBar = SnackBar(
                                            content:
                                                Text('password_updated'.tr()));
                                        final snackBar2 = SnackBar(
                                            content: Text(
                                                'invalid_confirmed_password'
                                                    .tr()));
                                        if (oldPasswordController.text.length <
                                            6) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar3);
                                        } else if (passwordController.text ==
                                                confirmPassController.text &&
                                            passwordController.text.length >=
                                                6) {
                                          updateAuthPassword();
                                          // Navigator.of(context).pop();
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

  Future _SelectPhoto() async {
    await showModalBottomSheet(context: context, builder: (context) =>
        BottomSheet(onClosing: () {}, builder: (context) =>
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(leading: Icon(Icons.camera),
                  title: Text("Camera"),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },),
                ListTile(leading: Icon(Icons.filter),
                  title: Text("Pick Image"),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },)
              ],
            )));
  }
  final ImagePicker _picker = ImagePicker();
  Future _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
        source: source, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }
    var file = await ImageCropper().cropImage(sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }
    File file2 = await CompressImage(file.path, 35);
    await _uploadFile(file2.path);
  }

  Future CompressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(
        path,newPath,quality: quality);
    return result;
  }

  Future _uploadFile (String path)async{

    final ref= await FirebaseStorage.instance
        .ref()
        .child("users")
        .child("profile_picture")
        .child(FirebaseAuth.instance.currentUser!.uid);
    final result =await ref.putFile(File(path));
    final fileUrl=await result.ref.getDownloadURL();
    user
    .child(FirebaseAuth.instance.currentUser!.uid).child('avatar').set(fileUrl);
    setState((){
      _image= File(fileUrl);
      _imagePath = fileUrl;
      print("Hello "+fileUrl);
    });
    // widget.onFilechanged(fileUrl);
  }

  chooseImage() async {
    //open gallery to upload image
    // XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
// print("filattoooo" + image!.path);
    // setState(() {
    //   _image = File(image.path);
    // });

    _SelectPhoto();
    // UserImage(
    //   onFilechanged: (String imageUrl) {
    //     print("filattoooo" + imageUrl);
    //     setState(() {
    //       _image = File(imageUrl);
    //     });
    //     print(_image);
    //   },
    // );

    // print(_image);
  }

  updateAuthEmail() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController passController = TextEditingController();
        return AlertDialog(
          title: Text('update_email'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('insert_password_to_confirm'),
                TextField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passController,
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                String pass = passController.text;
                firebaseUser!.reauthenticateWithCredential(
                    EmailAuthProvider.credential(
                        email: firebaseUser.email!, password: pass));
                firebaseUser.updateEmail(emailyController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('email_updated'.tr())));
                changedEmail = false;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  updateAuthPassword() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    String pass = oldPasswordController.text;
    firebaseUser!.reauthenticateWithCredential(EmailAuthProvider.credential(
        email: firebaseUser.email!, password: pass));
    return await firebaseUser.updatePassword(passwordController.text);
  }

  updateAuthName() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    return await firebaseUser?.updateDisplayName(nameController.text);
  }

  updateAuth() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    emaily = firebaseUser?.email;
    if (await firebaseUser != null) {
      if (changedEmail) firebaseUser?.updateEmail(emailyController.text);

      if (changedName) firebaseUser?.updateDisplayName(nameController.text);

      if (changedPassword)
        firebaseUser?.updatePassword(passwordController.text);
      // signed in
    } else {}

    print("updated");
  }

  updateProfile(BuildContext context) async {
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
    if (changedName) {
      print("Hello changed name");
      map['name'] = nameController.text;
      await updateAuthName();
      changedName = false;
    }
    if (changedAddress) {
      map['workshop/latitude'] = location!.latitude;
      map['workshop/longitude'] = location!.longitude;
      final address = await searchCoordinateAddressGoogle(
          lat: location!.latitude, long: location!.longitude);
      map['workshop/address'] = address;
      setState(() {
        addressController.text = address;
      });
    }
    if (changedPhone) {
      map['phoneNumber'] = phoneController.text;
      changedPhone = false;
    }
    if (changedEmail) {
      await updateAuthEmail();
      print("changedEmail: ${changedEmail}");
      if (!changedEmail) // changed
        map['email'] = emailyController.text;
    }
    if (changedWorkshopType) {
      map['isCenter'] = isCenter;
      changedWorkshopType = false;
    }
    if (changedWorkshopName) {
      map['workshop/name'] = shopNameController.text;
      changedWorkshopName = false;
    }
    if (_image != null) {
      map['image'] = await uploadImage(context);
      _image = null;
    }

    user.child(FirebaseAuth.instance.currentUser!.uid).update(map);
    // fetch();
  }

  Future<String> uploadImage(BuildContext context) async {
    TaskSnapshot taskSnapshot = await FirebaseStorage.instance
        .ref()
        .child("users")
        .child("profile_picture")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .putFile(_image!);

    //get image for current user from fireStorage
    dynamic url = await taskSnapshot.ref.getDownloadURL();

    // ref.watch(userProvider.notifier).assignAvatar(url);

    //RTDB
    // user
    //     .child(FirebaseAuth.instance.currentUser!.uid)
    //     .update({'image': url});
    // print("reading");
    // print(url.toString());
    return url;
  }

  fetch() async {
    final firebaseuser = await FirebaseAuth.instance.currentUser;
    user.child(FirebaseAuth.instance.currentUser!.uid).once().then((event) {
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
