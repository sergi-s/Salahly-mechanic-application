import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly_mechanic/classes/provider/pending_requests_notifier.dart';
import 'package:salahly_mechanic/main.dart';
import 'package:salahly_mechanic/screens/Requests/done_requests_fulldata.dart';
import 'package:salahly_models/models/road_side_assistance.dart';

import '../../widgets/global_widgets/app_bar.dart';
import '../../widgets/global_widgets/app_drawer.dart';

class DoneRequests extends ConsumerStatefulWidget {
  static const String routeName = "/doneRequests";

  const DoneRequests({Key? key}) : super(key: key);

  @override
  ConsumerState<DoneRequests> createState() => _OngoingRequestsState();
}

class _OngoingRequestsState extends ConsumerState<DoneRequests> {
  List<RSA> doneRequestsList = [];

  @override
  initState() {
    setState(() {
      doneRequestsList = PendingRequestsNotifier.doneRSA;
    });
    super.initState();
  }
  // final String requestType = RSA.requestTypeToString(rsa.requestType!);
  // final String carNumber=rsa.car!.noPlate;
  // final String carModel=rsa.car!.model!;
  @override
  Widget build(BuildContext context) {
    // print("doneRequestsList.length: ${doneRequestsList.length}");
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(0xFFd1d9e6),
          appBar: salahlyAppBar(context,title: "done_requests".tr()),
          // drawer: salahlyDrawer(context),
          body: CustomPaint(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: Color(0xFFd1d9e6),
              ), // red as border color
              child: SafeArea(
                  child: AnimationLimiter(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        reverse: false,
                        itemCount: doneRequestsList.length,
                        itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.push(DoneRequestsFullData.routeName,
                                extra: doneRequestsList[index]);
                          },
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10,
                              margin: const EdgeInsets.all(10),
                              child: Container(
                                height: MediaQuery.of(context).size.height * 0.13,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.grey[100],
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.blueGrey,
                                        blurRadius: 2.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(3, 0),
                                      ),
                                    ]),
                                child: Center(
                                  child: SingleChildScrollView(
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.grey[100],
                                        backgroundImage:
                                        AssetImage("assets/images/success.png"),
                                      ),
                                      // Text(ongoingRequestsList[index].car!.noPlate),
                                      title: Row(
                                        children: [
                                          Text(
                                            doneRequestsList[index].car!.model!,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: Color(0xFF193566)),
                                          ),
                                          // const Expanded(
                                          //     child: Divider(
                                          //       thickness: 0,
                                          //       color: Colors.transparent,
                                          //     )),
                                          // Text(
                                          //   "3.4 ",
                                          //   style: const TextStyle(
                                          //       fontSize: 20,
                                          //       color: Color(0xFFA38A00)),
                                          // ),
                                        ],
                                      ),
                                      subtitle: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              Text(
                                                "car_number".tr()+' : '+doneRequestsList[index].car!.noPlate,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF193566),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "request_type".tr()+' : '+RSA.requestTypeToString(doneRequestsList[index].requestType!),
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xFF193566),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        );
                        }),
                  )),
            ),
          )),
    );
  }
}
