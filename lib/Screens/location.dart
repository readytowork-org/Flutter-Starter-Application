import 'dart:async';

import 'package:basic_app/components/alert_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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

  List<Marker> markerList = [];

  List<Placemark> addresses = [];
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

  animateCamera(locationValue) async {
    //set caera position to userlocation
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(locationValue.latitude, locationValue.longitude),
      zoom: 14.4746,
    );

    final GoogleMapController newMapController =
        await _controllerGoogleMap.future;
    newMapController
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

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
      var locationDetails = await placemarkFromCoordinates(
          myLocation.latitude, myLocation.longitude);
      print(locationDetails.runtimeType);
      print(locationDetails);

      addresses = locationDetails;
      animateCamera(myLocation);

//modal at bottom of screen
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Container(
              decoration: const BoxDecoration(color: Colors.white),
              margin: const EdgeInsets.all(10.0),
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                child: Wrap(
                  children: [
                    const Text(
                      "User Location is",
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${locationDetails[0].name}, ${locationDetails[0].locality}, ${locationDetails[0].subAdministrativeArea}, ${locationDetails[0].country}",
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            );
          });
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

  addMarkers(argument) async {
    print(argument);

    print(markerList);

    animateCamera(argument);

    // CameraPosition cameraPosition = CameraPosition(
    //   target: argument,
    //   zoom: 14.4746,
    // );

    // final GoogleMapController newMapController =
    //     await _controllerGoogleMap.future;
    // newMapController
    //     .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    Marker userlocation = Marker(
      draggable: true,
      onDragEnd: ((newPosition) {
        // print('the new location is $newPosition');
        // print(newPosition.longitude);/
      }),
      markerId: MarkerId(argument.toString()),
      position: argument,
      infoWindow: const InfoWindow(title: 'Business 2'),
      icon: BitmapDescriptor.defaultMarker,
    );
    markerList.add(userlocation);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Location")),
        body:
            // ? const Center(child: CupertinoActivityIndicator())
            // :
            GoogleMap(
          markers: Set<Marker>.from(markerList),
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          onLongPress: addMarkers,
          onMapCreated: (GoogleMapController googleMapController) {
            _controllerGoogleMap.complete(googleMapController);
          },
        ));
  }
}
