
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:salahly_mechanic/widget/profile_widget.dart';
import 'package:path/path.dart' as p;
import 'package:salahly_mechanic/widgets/login_signup/rounded_Image.dart';

class UserImage extends StatefulWidget {
   UserImage({Key? key, required this.onFilechanged}) : super(key: key);
  final Function(String imageUrl) onFilechanged;

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final ImagePicker _picker = ImagePicker();

  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        if(imageUrl == null)
          Image.asset(
            'assets/images/user.png',width: MediaQuery.of(context).size.width/2.6,),
        if(imageUrl != null)
        InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: ()=>_SelectPhoto(),
          child: AppRoundedImage.url(
    imageUrl!,
              height:size.height/2,
              width:size.height/2,
    ), ),


      ],
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
    file = await CompressImage(file.path, 35);
    await _uploadFile(file!.path);
  }

  Future CompressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');
    final result = await FlutterImageCompress.compressAndGetFile(
        path,newPath,quality: quality);
    return result;
  }
  Future _uploadFile (String path)async{
    final ref=await FirebaseStorage.instance
        .ref()
        .child("users")
        .child("profile_picture")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child('${DateTime.now().toIso8601String()+p.basename(path)}');
    final result =await ref.putFile(File(path));
    final fileUrl=await result.ref.getDownloadURL();
    setState((){
      imageUrl=fileUrl;
    });
    widget.onFilechanged(fileUrl);
  }

}




