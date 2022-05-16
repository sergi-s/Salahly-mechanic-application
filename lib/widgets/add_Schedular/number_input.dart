import 'package:flutter/material.dart';

class MyNumberInputField extends StatelessWidget {
  final String title;
  final String hint;
  final Function fn;
  final Widget? widget;
  final TextEditingController? controller;
  int? initialValue;

  MyNumberInputField(
      {Key? key,
        required this.title,
        required this.hint,
        required this.fn,
        this.controller,
        this.widget, initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 16),

      // width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF193566)),
          ),
          Container(
              height: 52,
              padding: const EdgeInsets.only(left: 14),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(3, 0),
                    ),
                  ]),
              child: Row(
                children: [
                  widget == null
                      ? Container()
                      : Container(
                    child: widget,
                  ),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        fn(value);
                      },
                      readOnly: widget == null ? false : true,
                      initialValue: initialValue == null ? "" : initialValue.toString(),
                      autofocus: false,
                      cursorColor: Colors.blue,
                      controller: controller,
                      // controller: controller,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[900],
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        // errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: hint,
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
