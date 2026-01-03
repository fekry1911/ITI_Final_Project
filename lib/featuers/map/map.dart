import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import '../../core/const/const_paths.dart';
import '../near_stations/data/model/near_stations_model.dart';
import '../near_stations/logic/get_nearby_stations_cubit.dart';

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    context.read<GetNearbyStationsCubit>().getNearbyStations();
  }



  Future<void> _updateMarkers(
      Position userPosition,
      List<NearStationModel> stations,
      ) async {
    Set<Marker> tempMarkers = {};

    final userLatLng =
    LatLng(userPosition.latitude, userPosition.longitude);

    tempMarkers.add(
      Marker(
        markerId: const MarkerId('me'),
        position: userLatLng,
        infoWindow: const InfoWindow(title: 'مكاني'),
      ),
    );

    for (var station in stations) {
      final stationLat = station.location.coordinates[1];
      final stationLng = station.location.coordinates[0];

      final distanceAndTime = calculateDistanceAndTime(
        userPosition,
        stationLat,
        stationLng,
      );

      tempMarkers.add(
        Marker(
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),

          markerId: MarkerId(station.id.toString()),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
          position: LatLng(stationLat, stationLng),
          infoWindow: InfoWindow(
            onTap: () {
              context.pushNamed(stationDetailsScreen, arguments: station.id);
            },
            title: station.stationName,
            snippet: '$distanceAndTime • ${station.status}',
          ),
        ),
      );
    }

    setState(() {
      markers = tempMarkers;
    });

    final controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLngZoom(userLatLng, 11),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetNearbyStationsCubit, GetNearbyStationsState>(
      listener: (context, state) {
        if (state is GetNearbyStationsSuccess) {
          _updateMarkers(state.userPosition, state.data);
        }
      },
      child: GoogleMap(
        mapType: MapType.satellite,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: const CameraPosition(
          target: LatLng(30.0444, 31.2357),
          zoom: 6,
        ),
        markers: markers,
        onMapCreated: (controller) async {
          _controller.complete(controller);


        },
      ),
    );
  }
}
String calculateDistanceAndTime(
    Position userPosition,
    double stationLat,
    double stationLng,
    ) {
  final distanceInMeters = Geolocator.distanceBetween(
    userPosition.latitude,
    userPosition.longitude,
    stationLat,
    stationLng,
  );

  final distanceInKm = distanceInMeters / 1000;

  const double speedKmPerHour = 40;
  final timeInMinutes =
  ((distanceInKm / speedKmPerHour) * 60).round();

  return '${distanceInKm.toStringAsFixed(1)} km • $timeInMinutes min';
}