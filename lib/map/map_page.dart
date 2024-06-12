import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';


class MapPage extends StatefulWidget {
   MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  
  static LatLng _pGooglePlex = LatLng(-8.1726, 113.6995);
  static LatLng _pApplePark = LatLng(-8.000, 113.0000);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
      markers: {
        Marker(
          markerId: MarkerId("_currentLocation"),
          icon: BitmapDescriptor.defaultMarker,
          position: _pGooglePlex),
        Marker(
          markerId: MarkerId("_sourceLocation"),
          icon: BitmapDescriptor.defaultMarker,
          position: _pApplePark),
      },
      ),
    );

  }
}