import 'dart:async';

import 'package:basic_app/components/alert_dialog.dart';
import 'package:basic_app/utilities/routes.dart';

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
  final TextEditingController _filter = TextEditingController();
  bool mainTitle = true;

  List<Marker> markerList = [];
  List<Placemark> addresses = [];

  Map<String, dynamic> initialLocation = {};
  // String _stringValue = "";
  List searchedAddress = [];
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
    _filter.dispose();
  }

  // Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
  //   String url =
  //       "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
  //   http.Response response = await http.get(url);
  //   Map values = jsonDecode(response.body);
  //   return values["routes"][0]["overview_polyline"]["points"];
  // }

  animateCamera(locationValue) async {
    print('${locationValue.latitude} ${locationValue.longitude}');
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
        textOption1: "Yes",
        textOption2: "No",
        alertTitle: "Permission Denied",
        alertMessage: "Do you want to open Settings?",
        onPressYesButton: () {
          openAppSettings();
          Navigator.pop(context);
        },
        onPressNoButton: () {
          Navigator.pop(context);
        },
      );
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

      // modal at bottom of screen
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return Container(
      //         decoration: const BoxDecoration(color: Colors.white),
      //         margin: const EdgeInsets.all(10.0),
      //         padding: const EdgeInsets.all(10.0),
      //         child: Expanded(
      //           child: Wrap(
      //             children: [
      //               const Text(
      //                 "User Location is",
      //                 style: TextStyle(fontSize: 17),
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               Text(
      //                 "${locationDetails[0].name}, ${locationDetails[0].locality}, ${locationDetails[0].subAdministrativeArea}, ${locationDetails[0].country}",
      //                 style: const TextStyle(fontSize: 20),
      //               ),
      //             ],
      //           ),
      //         ),
      //       );
      //     });
    } else {
      ShowDialogBox.dialogBoxes(
        context: context,
        textOption1: "Yes",
        textOption2: "No",
        alertTitle: "Restricted",
        alertMessage: "This feature restricted in your device",
        onPressYesButton: () {
          Navigator.pop(context);
        },
        onPressNoButton: () {
          Navigator.pop(context);
        },
      );
    }
  }

  addMarkers(argument) async {
    print(
        "in add markers ${argument} ${argument.latitude} ${argument.longitude}");

    print(markerList);

    animateCamera(argument);

    Marker userlocation = Marker(
      draggable: true,
      onDragEnd: ((newPosition) {
        // print('the new location is $newPosition');
        // print(newPosition.longitude);/
      }),
      markerId: MarkerId(argument.toString()),
      position: LatLng(argument.latitude, argument.longitude),
      infoWindow: InfoWindow(
          title:
              ' ${argument.latitude}, ${argument.longitude} \nGet Directions'),
      icon: BitmapDescriptor.defaultMarker,
    );

    setState(() {
      markerList = [userlocation];
    });
  }

  AppBar buildBar(BuildContext context) {
    return AppBar(
        centerTitle: false,
        title: const Text("Location"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, RoutesAvailable.searchRoute);
              // setState(() {
              //   mainTitle = false;
              // });
            },
            icon: const Icon(Icons.search),
            padding: const EdgeInsets.only(right: 15),
          )
        ]);
  }

  // _appBarTitle() {
  //   if (!mainTitle) {
  //     return TextField(
  //         onChanged: (value) {
  //           setState(() {
  //             _stringValue = value;
  //           });
  //         },
  //         autofocus: true,
  //         decoration: InputDecoration(
  //           prefixIcon: IconButton(
  //             icon: const Icon(
  //               Icons.close,
  //             ),
  //             onPressed: () {
  //               setState(() {
  //                 mainTitle = true;
  //               });
  //             },
  //           ),
  //           suffixIcon: IconButton(
  //             icon: const Icon(
  //               Icons.search,
  //             ),
  //             onPressed: () async {
  //               try {
  //                 searchedAddress = await locationFromAddress(_stringValue);
  //                 print("the searched address is $searchedAddress[0]");
  //                 addMarkers(searchedAddress[0]);
  //               } catch (e) {
  //                 print('error while fetching coordinates $e');
  //               }
  //             },
  //           ),
  //           contentPadding:
  //               const EdgeInsets.symmetric(vertical: 9, horizontal: 2),
  //           fillColor: Colors.grey[300],
  //           filled: true,
  //           hintText: "Search",
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.circular(5.0),
  //             borderSide: const BorderSide(color: Colors.white, width: 2.0),
  //           ),
  //         ));
  //   } else {
  //     _filter.clear();
  //     return const Text("Location");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildBar(context),
        body:
            // ? const Center(child: CupertinoActivityIndicator())
            // :
            GoogleMap(
          markers: Set<Marker>.from(markerList),
          initialCameraPosition: cameraPosition,
          myLocationEnabled: true,
          zoomGesturesEnabled: true,
          // onLongPress: addMarkers,
          onMapCreated: (GoogleMapController googleMapController) {
            _controllerGoogleMap.complete(googleMapController);
          },
        ));
  }
}
