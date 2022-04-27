import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salahly_mechanic/classes/firebase/customgeofire.dart';

class SetAvalability extends StatelessWidget {

  SetAvalability({Key? key}) : super(key: key);
  static final routeName = "/setavalabilityscreen";
  NearbyLocations as=NearbyLocations();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ToggleSwitch(
          minWidth: 90.0,
          initialLabelIndex: 1,
          cornerRadius: 20.0,
          activeFgColor: Colors.white,
          inactiveBgColor: Colors.grey,
          inactiveFgColor: Colors.white,
          totalSwitches: 2,
          labels: ['', ''],
          icons: [FontAwesomeIcons.faceSadCry, FontAwesomeIcons.faceKissWinkHeart],
          activeBgColors: [[Colors.red],[Colors.green]],
          onToggle: (index) async{
            if(index==0){
            await NearbyLocations.setAvailabilityOff();
            }
            if(index==1){
              await NearbyLocations.setAvailabilityOn();
            }

          },
        ),
      ),
    );
  }
}
