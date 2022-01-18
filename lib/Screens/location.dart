import 'dart:async';

import 'package:basic_app/components/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  // late Position _position;

  final CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    userPosition();
  }

  //   @override
  // void dispose() {
  //   super.dispose();
  //   _controllerGoogleMap.dispose();
  // }

  userPosition() async {
    var permission = await Geolocator.requestPermission();
    print("the permission result is $permission");
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ShowDialogBox.dialogBoxes(
          context: context,
          alertTitle: "Permission Denied",
          alertMessage: "Do you want to open Settings?",
          onPressYesButton: () {
            openAppSettings();
            Navigator.pop(context);
          },
          onPressNoButton: () {
            Navigator.pop(context);
          });
    } else if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position myLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      //set caera position to userlocation
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(myLocation.latitude, myLocation.longitude),
        zoom: 14.4746,
      );

      final GoogleMapController newMapController =
          await _controllerGoogleMap.future;
      newMapController
          .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      print(myLocation);
    } else {
      ShowDialogBox.dialogBoxes(
          context: context,
          alertTitle: "Restricted",
          alertMessage: "This feature restricted in your device",
          onPressYesButton: () {
            Navigator.pop(context);
          },
          onPressNoButton: () {
            Navigator.pop(context);
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            // ? const Center(child: CupertinoActivityIndicator())
            // :
            GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      onMapCreated: (GoogleMapController googleMapController) {
        _controllerGoogleMap.complete(googleMapController);
      },
    ));
  }
}
