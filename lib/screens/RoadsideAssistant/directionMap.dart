import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import "package:flutter/material.dart";
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:salahly_mechanic/screens/Requests/pending_requests.dart';
import 'package:salahly_models/models/location.dart';

import '../../utils/location/getuserlocation.dart';

class RideLocations extends StatefulWidget {
  static const routeName = "/staticLocationOnMap";

  static String? result;

  BundledLocation bundledLocation;

  RideLocations({Key? key, required this.bundledLocation}) : super(key: key);

  @override
  State<RideLocations> createState() => _RideLocationsState();
}

class _RideLocationsState extends State<RideLocations> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController newGoogleMapController;

  static const double initialCameraZoom = 18;
  double cameraZoom = 14;

  Geolocator geoLocator = Geolocator();

  //initial Camera position
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: initialCameraZoom,
  );

  //Markers
  Map<MarkerId, Marker> markers = {};

  late CustomLocation clientLocation;
  late CustomLocation destinationLocation;

  @override
  void initState() {
    clientLocation = widget.bundledLocation.clientLocation!;
    destinationLocation = widget.bundledLocation.destinationLocation!;

    // print(clientLocation.toString());
    // print(destinationLocation.toString());

    // _originLatitude = clientLocation.latitude;
    // _originLongitude = clientLocation.longitude;
    // _destLatitude = destinationLocation.latitude;
    // _destLongitude = destinationLocation.longitude;

    _addMarker(LatLng(clientLocation.latitude, clientLocation.longitude),
        "origin", BitmapDescriptor.defaultMarker);

    /// destination marker
    _addMarker(
        LatLng(destinationLocation.latitude, destinationLocation.longitude),
        "destination",
        BitmapDescriptor.defaultMarkerWithHue(90));

    moveCamera(clientLocation);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  moveCamera(clientLocation);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  primary: const Color(0xFF193566),
                  padding: const EdgeInsets.all(20),
                ),
                child: Text("client".tr())),
            ElevatedButton(
                onPressed: () {
                  moveCamera(destinationLocation);
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF193566),
                ),
                child: Text("destination".tr()))
          ],
        ),
        body: Stack(children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
                target: LatLng(31.235203, 29.948837), zoom: 15),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
            },
            markers: Set<Marker>.of(markers.values),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 1,
              child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black,
                            blurRadius: 16,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ]),
                  // child: Padding(
                  //   padding: const EdgeInsets.symmetric(
                  //       horizontal: 24, vertical: 18),
                  //   child: 
                  //   Column(
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         // Text(("Distance ${calculateDistance(clientLocation.latitude, clientLocation.longitude, destinationLocation.latitude, destinationLocation.longitude).toStringAsExponential(3)}"),
                  //         //     style: const TextStyle(fontSize: 20)),
                  //         const SizedBox(height: 20),
                  //       ]),
                  // ),
                  ))
        ]),
      ),
    );
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  moveCamera(CustomLocation cus) async {
    // print("gp Tp ${cus}");
    LatLng latLatPosition = LatLng(cus.latitude, cus.longitude);
    setState(() {
      CameraPosition camPos = CameraPosition(target: latLatPosition, zoom: 17);
      newGoogleMapController
          .animateCamera(CameraUpdate.newCameraPosition(camPos));
    });
  }
}
