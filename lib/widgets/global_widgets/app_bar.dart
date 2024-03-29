import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

PreferredSizeWidget salahlyAppBar(BuildContext context, {String? title, bool? showBackButton }) {
  return AppBar(
    leading: showBackButton !=null ? IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => Navigator.pop(context),
    ) : null,
    title: title != null
        ? Text(title)
        : Image.asset('assets/images/logo white.png',
            fit: BoxFit.contain, scale: 50),
    centerTitle: true,
    backgroundColor: const Color(0xff193566),
    actions: title != null?[
      Image.asset('assets/images/logo white.png',
           width:80),
      ///TODO
    ]:[],
    // actions: [
    //   Consumer(
    //     builder: (context, ref, child) {
    //       return Container(
    //           // alignment: Alignment.centerRight,
    //           padding: const EdgeInsets.only(left: 0.0, right: 10.0),
    //           child: GestureDetector(
    //             onTap: ()=> print("tapped"),
    //                 // context.push(Profile.routeName),
    //             child: CircleAvatar(
    //                   backgroundImage:
    //                       NetworkImage(ref.watch(userProvider).avatar ?? ""),
    //                 ),
    //           ));
    //     },
    //   )
    // ],
  );
}

//TODO: el image el mawgoda fl Appbar mynf34 tkon hardcoded mknha
