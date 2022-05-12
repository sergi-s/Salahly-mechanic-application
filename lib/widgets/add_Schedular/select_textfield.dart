import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:salahly_mechanic/widgets/report/Input_container.dart';


class SelectRequest extends StatefulWidget {
  final String title;
  final String hintText;
  final Function onChangedfunction;
  final List<String> items;
  SelectRequest({Key? key, required this.hintText,required this.onChangedfunction,required this.items,required this.title }) : super(key: key);

  @override
  State<SelectRequest> createState() => _SelectRequestState();
}

class _SelectRequestState extends State<SelectRequest> {
  // final items = widget.items;
  String selectedValue ='Car Type';

  // late get hintText ;

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      // height:70,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(
          widget.title,
          style: TextStyle(
              fontSize: 16,
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
            child: DropdownButtonFormField2<String>(

              decoration: InputDecoration(
                hintText: widget.hintText,
                border: InputBorder.none,
              ),
              // value: selectedValue,
              onChanged: (newValue) {
                setState(() => selectedValue = newValue!);
                widget.onChangedfunction(newValue);
              },
              items: widget.items
                  .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  ))
                  .toList()
              ,

              // add extra sugar..
              icon: Padding(
                padding: EdgeInsets.fromLTRB(100,0,0,0),
                child: Icon(Icons.arrow_drop_down,color: Colors.grey,),
              ),
               iconSize:40,
              // underline: SizedBox(),
            ),
          ),
        ],
      ),
    )

    ;
  }
}
