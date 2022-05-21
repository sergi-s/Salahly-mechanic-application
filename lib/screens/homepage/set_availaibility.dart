import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salahly_mechanic/classes/firebase/customgeofire.dart';

class SetAvailability extends StatelessWidget {

  const SetAvailability({Key? key}) : super(key: key);
  static const routeName = "/set_availability_screen";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ToggleSwitch(
        minWidth: 90.0,
        initialLabelIndex: 1,
        cornerRadius: 20.0,
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.grey,
        inactiveFgColor: Colors.white,
        totalSwitches: 2,
        labels: const ['', ''],
        icons: const [FontAwesomeIcons.faceSadCry, FontAwesomeIcons.faceKissWinkHeart],
        activeBgColors: const [ [Colors.red], [Colors.green]],
        onToggle: (index) async{
          if(index==0){
          await NearbyLocations.setAvailabilityOff();
          }
          if(index==1){
            await NearbyLocations.setAvailabilityOn();
          }

        },
      ),
    );
  }
}
