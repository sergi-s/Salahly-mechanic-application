import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/screens/RoadsideAssistant/directionMap.dart';
import 'package:salahly_mechanic/utils/get_user_type.dart';
import 'package:salahly_mechanic/widgets/global_widgets/app_bar.dart';
import 'package:salahly_models/abstract_classes/user.dart';
import 'package:salahly_models/models/location.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

class PendingRequests extends ConsumerStatefulWidget {
  static final routeName = "/viewrequests";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PendingRequestsState();
  }
}

class _PendingRequestsState extends ConsumerState<PendingRequests> {
  String? estimatedTime;

  TextEditingController controller = TextEditingController();
  Widget personDetailCard(
      {required RSA rsa,
      required BuildContext context,
      required Function onConfirmRequest,
      required Function onRefuseRequest}) {
    return Container(
      // height: 120,
      alignment: Alignment.center,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.grey[100],
        semanticContainer: true,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          // onTap: () async {
          //   if (await confirm(
          //     context,
          //     title: const Text('Confirm').tr(),
          //     content: const Text('Car is Broken').tr(),
          //     textOK: const Text('Yes').tr(),
          //     textCancel: const Text('No').tr(),
          //   )) {
          //     return print('pressedOK');
          //   }
          //   return print('pressedCancel');
          // },
          child: Container(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: (rsa.car != null && rsa.car?.color != null)
                        ? rsa.car!.color!
                        : const Color(0xFF000000),
                  ),
                  title: Column(
                    children: <Widget>[
                      Text(
                        // Client.carmodel,
                        RSA.requestTypeToString(rsa.requestType!),
                        style: const TextStyle(
                            color: Color(0xff193566),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (rsa.car != null && rsa.car?.model != null)
                            ? rsa.car!.model!
                            : "",
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 18),
                      ),
                      Text(
                        (rsa.car != null) ? rsa.car!.noPlate : "",
                        style: const TextStyle(
                            color: Colors.black45, fontSize: 18),
                      ),
                    ],
                  ),
                  trailing: _trailing(rsa, onConfirmRequest, onRefuseRequest),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> _checkingrsaId = [];
  _trailing(RSA rsa, Function onConfirmRequest, Function onRefuseRequest) {
    if ((rsa.state == RSAStates.providerConfirmed ||
            rsa.state == RSAStates.mechanicConfirmed) &&
        rsa.requestType != RequestType.RSA) {
      return Text(
        "pending".tr(),
        style: TextStyle(color: Colors.red, fontSize: 18),
      );
    } else if (_checkingrsaId.contains(rsa.rsaID)) {
      return Text(
        "checking",
        style: TextStyle(color: Colors.blueAccent, fontSize: 18),
      );
    } else {
      return actionsRow(
          onConfirmRequest: onConfirmRequest, onRefuseRequest: onRefuseRequest);
    }
  }

  Widget build(BuildContext context) {
    PendingRequestsNotifier pendingNotifier =
        ref.watch(pendingRequestsProvider.notifier);
    List<RSA> pendingRequests = ref.watch(pendingRequestsProvider);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFd1d9e6),
      appBar: salahlyAppBar(
        context,
        title: "pending_requests".tr(),
      ),
      // drawer: salahlyDrawer(context),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: pendingRequests.map((p) {
              return personDetailCard(
                  rsa: p,
                  context: context,
                  onConfirmRequest: () async {
                    if (userType == Type.provider) {
                      await _getEstimatedTime(context, p);
                      print("????${estimatedTime}");
                    }
                    if (userType == Type.provider &&
                        (estimatedTime == null || estimatedTime == "")) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(content: Text('Please Enter estimat')));
                      // const SnackBar(content: Text('Please Enter estimat'));
                      return;
                    }
                    if (await confirm(
                      context,
                      title: const Text('confirm').tr(),
                      content: Text('would_you_accept_request'.tr()),
                      textOK: const Text('yes').tr(),
                      textCancel: const Text('no').tr(),
                    )) {
                      if (userType == Type.provider) {
                        _accept(p, pendingNotifier, estimatedTime!);
                      } else if (userType == Type.mechanic) {
                        await pendingNotifier.acceptRequest(p);
                      }

                      return print('pressedOK');
                    }
                    estimatedTime = null;
                    return print('pressedCancel');
                  },
                  onRefuseRequest: () {
                    pendingNotifier.denyRequest(p);
                  });
            }).toList()),
      ),
    );
  }

  void _accept(p, pendingNotifier, String estimatedTime) async {
    if (p.requestType == RequestType.RSA) {
      setState(() {
        _checkingrsaId.add(p.rsaID);
      });
      await pendingNotifier.acceptRequest(p);
      setState(() {
        _checkingrsaId.remove(p.rsaID!);
      });
    } else {
      await pendingNotifier.acceptRequest(p);
    }
    setEstimatedTime(p);
  }

  setEstimatedTime(RSA rsa) async {
    var reqVar = "";
    if (userType == Type.provider) {
      reqVar = "providersRequests";
    } else if (userType == Type.mechanic) {
      reqVar = "mechanicsRequests";
    }
    await FirebaseDatabase.instance
        .ref()
        .child(reqVar)
        .child(FirebaseAuth.instance.currentUser!.uid)
        .child(rsa.rsaID!)
        .child("estimatedTime")
        .set(estimatedTime);
  }

  _myDropOffLocationFunction(RSA p) {
    if(p.requestType == null) return;
    if(p.requestType == RequestType.TTA){
    return p.dropOffLocation ?? CustomLocation(longitude: 31.205753, latitude: 29.924526);
    }else if(p.mechanic != null && p.mechanic!.loc != null ) {
      return p.mechanic!.loc;
    }else {
       return CustomLocation(longitude: 31.205753, latitude: 29.924526);
    }
  }

  _getEstimatedTime(context, RSA p) async {
    bool checkEstimated = false;
    if (controller.text.isNotEmpty) checkEstimated = true;
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text("where_to".tr()),
                  content: Container(
                    // height: MediaQuery.of(context).size.height / 0.6,
                    height: 0.30 * MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.height,
                    child: ListView(children: [
                      (p.mechanic != null &&
                              p.mechanic!.loc != null &&
                              p.mechanic!.loc!.address != null)
                          ? Text(p.mechanic!.loc!.address!)
                          : Container(),
                      TextField(
                        controller: controller,
                        decoration: InputDecoration(
                            hintText: "enter_estimated_time".tr()),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            checkEstimated = value.isNotEmpty;
                          });
                        },
                      )
                    ]),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          // print("test ya rab${p.dropOffLocation}");
                          context.push(RideLocations.routeName,
                              extra: BundledLocation(
                                  destinationLocation:
                                      _myDropOffLocationFunction(p),
                                  clientLocation: p.location));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFF193566),
                          padding: const EdgeInsets.all(10),
                        ),
                        child: Text("Destinations".tr())),
                    ElevatedButton(
                      onPressed: checkEstimated
                          ? () {
                              onClick(context);
                            }
                          : null,
                      child: Text("confirm".tr()),
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF193566),
                        padding: const EdgeInsets.all(10),
                      ),
                    )
                  ],
                );
              },
            ));
  }

  void onClick(context) {
    estimatedTime = controller.text;
    Navigator.pop(context);
  }
}

class actionsRow extends StatelessWidget {
  const actionsRow(
      {Key? key, required this.onConfirmRequest, required this.onRefuseRequest})
      : super(key: key);
  final Function onConfirmRequest, onRefuseRequest;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          onPressed: () async {
            if (await confirm(
              context,
              title: Text('confirm'.tr()),
              content: Text('would_you_refuse_request'.tr()).tr(),
              textOK: Text('yes'.tr()),
              textCancel: Text('no'.tr()),
            )) {
              onRefuseRequest();
              return print('pressedOK');
            }
            return print('pressedCancel');
          },
          icon: const Icon(
            Icons.close,
            size: 35,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () async {
            onConfirmRequest();
            // if (await confirm(
            //   context,
            //   title: const Text('Confirm').tr(),
            //   content:
            //   Text('Would you like to Accept Request?'.tr()),
            //   textOK: const Text('Yes').tr(),
            //   textCancel: const Text('No').tr(),
            // )) {
            //   onConfirmRequest();
            //   return print('pressedOK');
            // }
            // return print('pressedCancel');
          },
          icon: const Icon(
            Icons.check,
            size: 35,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class BundledLocation {
  CustomLocation? destinationLocation, clientLocation;

  BundledLocation(
      {required this.destinationLocation, required this.clientLocation});
}
