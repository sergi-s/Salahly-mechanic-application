import 'package:flutter/cupertino.dart';

class AppRoundedImage extends StatelessWidget{
  final ImageProvider provider;
  final double height;
  final double width;

  AppRoundedImage(this.provider, {required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
   return ClipRect(
      child: Image(
        image: provider,
        height:height,
        width: width,
      ),
    );
  }

  factory AppRoundedImage.url(String url,{required double width, required double height}) {
    return AppRoundedImage(NetworkImage(url), width: width, height: height);
  }
}





