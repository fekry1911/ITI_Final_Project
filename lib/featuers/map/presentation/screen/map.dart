import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/const/const_paths.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../near_stations/data/model/near_stations_model.dart';
import '../../../near_stations/logic/get_nearby_stations_cubit.dart';
import '../logic/path_between_points_dart_cubit.dart';

enum TravelMode { car, bike, walk }

extension TravelModeExt on TravelMode {
  IconData get icon {
    switch (this) {
      case TravelMode.car:
        return Icons.directions_car;
      case TravelMode.bike:
        return Icons.directions_bike;
      case TravelMode.walk:
        return Icons.directions_walk;
    }
  }

  String get label {
    switch (this) {
      case TravelMode.car:
        return 'سيارة';
      case TravelMode.bike:
        return 'دراجة';
      case TravelMode.walk:
        return 'مشي';
    }
  }
}

extension TravelModeProfile on TravelMode {
  String get profile {
    switch (this) {
      case TravelMode.car:
        return 'driving-car';
      case TravelMode.bike:
        return 'cycling-regular';
      case TravelMode.walk:
        return 'foot-walking';
    }
  }
}

class MapSample extends StatefulWidget {
  const MapSample({super.key});

  @override
  State<MapSample> createState() => _MapSampleState();
}

class _MapSampleState extends State<MapSample> {
  LatLng? userLocation;
  List<NearStationModel> stations = [];
  NearStationModel? selectedStation;

  bool showBottom = false;
  String distanceKm = "";
  String durationMin = "";

  TravelMode selectedMode = TravelMode.car;

  late DraggableScrollableController sheetController;

  @override
  void initState() {
    super.initState();
    sheetController = DraggableScrollableController();
    context.read<GetNearbyStationsCubit>().getNearbyStations();
  }

  void _updateUserAndStations(
    Position userPosition,
    List<NearStationModel> data,
  ) {
    userLocation = LatLng(userPosition.latitude, userPosition.longitude);
    stations = data;
  }

  void _showStationBottomSheet({
    required String distance,
    required String duration,
  }) {
    setState(() {
      distanceKm = distance;
      durationMin = duration;
      showBottom = true;
    });

    if (sheetController.isAttached) {
      sheetController.animateTo(
        0.4,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GetNearbyStationsCubit, GetNearbyStationsState>(
          listener: (context, state) {
            if (state is GetNearbyStationsSuccess) {
              _updateUserAndStations(state.userPosition, state.data);
              setState(() {});
            }
          },
        ),
      ],
      child: userLocation == null
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Stack(
                children: [
                  /// MAP
                  BlocConsumer<
                    PathBetweenPointsDartCubit,
                    PathBetweenPointsDartState
                  >(
                    listener: (context, state) {
                      if (state.data != null &&
                          selectedStation != null &&
                          !state.isLoading) {
                        _showStationBottomSheet(
                          distance:
                              (state.data!.properties.summary.distance / 1000)
                                  .toStringAsFixed(1),
                          duration:
                              (state.data!.properties.summary.duration / 60)
                                  .toStringAsFixed(1),
                        );
                      }
                    },
                    builder: (context, state) {
                      final routePoints = state.data == null
                          ? <LatLng>[]
                          : state.data!.geometry.coordinates
                                .map<LatLng>((c) => LatLng(c[1], c[0]))
                                .toList();

                      return FlutterMap(
                        options: MapOptions(
                          initialCenter: userLocation!,
                          initialZoom: 13,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=LEn1OLsKC7G5Ow6TRLTC",
                            userAgentPackageName: 'flutter_map',
                          ),

                          /// MARKERS
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: userLocation!,
                                width: 60,
                                height: 60,
                                child: const Icon(
                                  Icons.person_pin_circle,
                                  color: Colors.green,
                                  size: 40,
                                ),
                              ),
                              for (final station in stations)
                                Marker(
                                  point: LatLng(
                                    station.location.coordinates[1],
                                    station.location.coordinates[0],
                                  ),
                                  width: 60,
                                  height: 60,
                                  child: GestureDetector(
                                    onTap: () {
                                      selectedStation = station;

                                      context
                                          .read<PathBetweenPointsDartCubit>()
                                          .getAllGeometry(
                                            coordinates: [
                                              [
                                                userLocation!.longitude,
                                                userLocation!.latitude,
                                              ],
                                              [
                                                station.location.coordinates[0],
                                                station.location.coordinates[1],
                                              ],
                                            ],
                                            mode: selectedMode,
                                          );
                                    },
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.purple,
                                      size: 40,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          /// ROUTE
                          if (routePoints.isNotEmpty)
                            PolylineLayer(
                              polylines: [
                                Polyline(
                                  points: routePoints,
                                  strokeWidth: 4,
                                  color: AppColors.mainColor,
                                ),
                              ],
                            ),
                        ],
                      );
                    },
                  ),

                  /// BOTTOM SHEET
                  if (showBottom && selectedStation != null)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: DraggableScrollableSheet(
                          controller: sheetController,
                          initialChildSize: 0.4,
                          minChildSize: 0.3,
                          maxChildSize: 0.7,
                          builder: (context, scrollController) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: ListView(
                                controller: scrollController,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 40,
                                      height: 4,
                                      margin: const EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade400,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    selectedStation!.stationName,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      _infoItem(
                                        Icons.route,
                                        "$distanceKm كم",
                                        Colors.blue,
                                      ),
                                      const SizedBox(width: 20),
                                      _infoItem(
                                        Icons.access_time,
                                        "$durationMin دقيقة",
                                        Colors.orange,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),

                                  /// MODE SELECTOR
                                  _travelModeSelector(),

                                  const SizedBox(height: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      context.pushNamed(
                                        stationDetailsScreen,
                                        arguments: selectedStation!.id,
                                      );
                                    },
                                    child: const Text("عرض تفاصيل المحطة"),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _travelModeSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: TravelMode.values.map((mode) {
        final isSelected = mode == selectedMode;

        return GestureDetector(
          onTap: () {
            setState(() {
              selectedMode = mode;
            });

            if (selectedStation != null) {
              context.read<PathBetweenPointsDartCubit>().getAllGeometry(
                coordinates: [
                  [userLocation!.longitude, userLocation!.latitude],
                  [
                    selectedStation!.location.coordinates[0],
                    selectedStation!.location.coordinates[1],
                  ],
                ],
                mode: mode,
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.mainColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  mode.icon,
                  color: isSelected ? Colors.white : Colors.black54,
                ),
                const SizedBox(width: 6),
                Text(
                  mode.label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _infoItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
