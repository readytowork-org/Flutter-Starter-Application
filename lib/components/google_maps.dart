import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RenderGoogleMaps extends StatefulWidget {
  const RenderGoogleMaps({Key? key}) : super(key: key);

  @override
  _RenderGoogleMapsState createState() => _RenderGoogleMapsState();
}

class _RenderGoogleMapsState extends State<RenderGoogleMaps> {
  static const CameraPosition _intialPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 100,
      child: GoogleMap(
        initialCameraPosition: _intialPosition,
      ),
    );
  }
}
