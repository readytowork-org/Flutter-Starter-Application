import 'package:basic_app/components/alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class RenderGoogleMaps extends StatefulWidget {
  const RenderGoogleMaps({Key? key}) : super(key: key);

  @override
  _RenderGoogleMapsState createState() => _RenderGoogleMapsState();
}

class _RenderGoogleMapsState extends State<RenderGoogleMaps> {
  // final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController newMapController;
  // late Position _position;

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
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

      //set caera position to userlocation
      CameraPosition _cameraPosition = CameraPosition(
        target: LatLng(myLocation.latitude, myLocation.longitude),
        zoom: 14.4746,
      );
      newMapController
          .animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));

      print(myLocation);
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

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: GoogleMap(
        initialCameraPosition: _cameraPosition,
        // onMapCreated: (GoogleMapController _googleMapController) {}
      ),
    );
  }
}
