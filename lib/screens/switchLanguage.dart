import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../widgets/global_widgets/app_bar.dart';
import '../widgets/global_widgets/app_drawer.dart';


class SwitchLanguageScreen extends StatefulWidget {
  static const routeName = "/switchlanguage";

  @override
  _SwitchLanguageScreenState createState() => _SwitchLanguageScreenState();
}

class _SwitchLanguageScreenState extends State<SwitchLanguageScreen> {
  Map<String, String> simpleMap = {"en": "English", "ar": "العربية"};
  String _dropDownValue = "en";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: salahlyAppBar(context, title: "change_lang".tr()),
        drawer: salahlyDrawer(context),
        body: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("change_lang".tr()),
                const SizedBox(width: 15),
                DropdownButton(
                  icon: const Icon(Icons.translate),
                  items: [
                    DropdownMenuItem<String>(
                        child: Text(simpleMap["en"]!), value: "en"),
                    DropdownMenuItem<String>(
                        child: Text(simpleMap["ar"]!), value: "ar"),
                  ],
                  value: _dropDownValue,
                  onChanged: (v) {
                    setState(() {
                      context.setLocale(Locale(v as String));
                      print("::lange");
                      _dropDownValue = v;
                    });
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
