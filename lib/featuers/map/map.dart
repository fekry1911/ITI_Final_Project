import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied';
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> _goToMyLocation() async {
    final position = await _determinePosition();
    final controller = await _controller.future;

    final myLatLng = LatLng(position.latitude, position.longitude);

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: myLatLng,
          zoom: 16,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357),
          zoom: 12,
        ),
        onMapCreated: (controller) {
          _controller.complete(controller);
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _goToMyLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
