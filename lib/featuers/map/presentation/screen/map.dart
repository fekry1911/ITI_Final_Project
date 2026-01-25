import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/map/presentation/screen/widgets/info.dart';
import 'package:iti_moqaf/featuers/map/presentation/screen/widgets/mode_selector.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/const/const_paths.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../near_stations/data/model/near_stations_model.dart';
import '../../../near_stations/logic/get_nearby_stations_cubit.dart';
import '../../data/models/mode.dart';
import '../logic/path_between_points_dart_cubit.dart';

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

  late TravelMode selectedMode;

  late DraggableScrollableController sheetController;
  late final MapController _mapController;

  void _fitRouteToCamera(List<LatLng> points) {
    if (points.isEmpty) return;

    final bounds = LatLngBounds.fromPoints(points);

    _mapController.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: const EdgeInsets.all(40)),
    );
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    selectedMode = TravelMode.car;
    sheetController = DraggableScrollableController();
    // context.read<GetNearbyStationsCubit>().getNearbyStations();
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
          : Stack(
        children: [
          BlocConsumer<
              PathBetweenPointsDartCubit,
              PathBetweenPointsDartState
          >(
            listener: (context, state) {
              if (state.data != null &&
                  selectedStation != null &&
                  !state.isLoading) {
                final points = state.data!.geometry.coordinates
                    .map<LatLng>((c) => LatLng(c[1], c[0]))
                    .toList();
                _fitRouteToCamera(points);
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

                mapController: _mapController,
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
                        child:  Icon(
                          Icons.person_pin_circle,
                          color: AppColors.redColor,
                          size: 30.r,

                        ),
                      ),
                      for (final station in stations)
                        Marker(

                          point: LatLng(
                            station.location.coordinates[1],
                            station.location.coordinates[0],
                          ),
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
                            child:  Icon(
                              Icons.location_on,
                              color: Colors.lightGreen,
                              size: 30.r,
                            ),
                          ),

                        ),
                    ],
                  ),
                  if (routePoints.isNotEmpty)
                    PolylineLayer(
                      polylines: [
                        Polyline(
                          strokeCap: StrokeCap.round,
                          strokeJoin: StrokeJoin.round,
                          pattern: selectedMode != TravelMode.car
                              ? StrokePattern.dotted()
                              : StrokePattern.solid(),
                          points: routePoints,
                          strokeWidth: 2.5,
                          color: AppColors.mainColor,
                        ),
                      ],
                    ),
                ],
              );
            },
          ),
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
                              infoItem(
                                Icons.route,
                                "$distanceKm كم",
                                Colors.blue,
                              ),
                              const SizedBox(width: 20),
                              infoItem(
                                Icons.access_time,
                                "$durationMin دقيقة",
                                Colors.orange,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          TravelModeSelector(
                            selectedMode: selectedMode,
                            onModeChanged: (mode) {
                              setState(() {
                                selectedMode = mode;
                              });

                              if (selectedStation != null) {
                                context
                                    .read<PathBetweenPointsDartCubit>()
                                    .getAllGeometry(
                                  coordinates: [
                                    [
                                      userLocation!.longitude,
                                      userLocation!.latitude,
                                    ],
                                    [
                                      selectedStation!
                                          .location
                                          .coordinates[0],
                                      selectedStation!
                                          .location
                                          .coordinates[1],
                                    ],
                                  ],
                                  mode: mode,
                                );
                              }
                            },
                          ),

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
      )
    );
  }
}
