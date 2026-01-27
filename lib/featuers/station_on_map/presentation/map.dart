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
import '../../../core/keys.dart';
import '../../../core/logic/tts/tts_cubit.dart';
import '../../../core/utils/determine_position.dart';
import '../../map/data/models/mode.dart';
import '../../map/presentation/logic/path_between_points_dart_cubit.dart';
import '../../stations_details/data/model/station_model.dart';

class StationOnMap extends StatefulWidget {
  StationOnMap({super.key, required this.stationModel});

  final StationModel stationModel;

  @override
  State<StationOnMap> createState() => _StationOnMapState();
}

class _StationOnMapState extends State<StationOnMap> {
  LatLng userLocation = const LatLng(30.0444, 31.2357);
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

  Future<void> _initLocationAndRoute() async {
    try {
      final position = (await determinePosition()) as Position;
      userLocation = LatLng(position.latitude, position.longitude);

      setState(() {});

      context.read<PathBetweenPointsDartCubit>().getAllGeometry(
        coordinates: [
          [userLocation!.longitude, userLocation!.latitude],
          [
            widget.stationModel.data.location.coordinates[0],
            widget.stationModel.data.location.coordinates[1],
          ],
        ],
        mode: selectedMode,
      );
    } catch (e) {
      debugPrint("Location error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    selectedMode = TravelMode.car;
    sheetController = DraggableScrollableController();

    _initLocationAndRoute();
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
    return BlocProvider(
      create: (context) => VoiceNavigationCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            BlocConsumer<
                PathBetweenPointsDartCubit,
                PathBetweenPointsDartState
            >(
              listener: (context, state) {
                if (state.data != null && !state.isLoading) {
                  context.read<VoiceNavigationCubit>().speakDirections(
                    state.data!.properties.segments[0].steps,
                  );

                  final points = state.data!.geometry.coordinates
                      .map<LatLng>((c) => LatLng(c[1], c[0]))
                      .toList();
                  _fitRouteToCamera(points);
                  _showStationBottomSheet(
                    distance: (state.data!.properties.summary.distance / 1000)
                        .toStringAsFixed(1),
                    duration: (state.data!.properties.summary.duration / 60)
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
                      "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=$mapKey",
                      userAgentPackageName: 'flutter_map',
                    ),

                    /// MARKERS
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: userLocation!,
                          child: Icon(
                            Icons.person_pin_circle,
                            color: AppColors.redColor,
                            size: 30.r,
                          ),
                        ),
                        Marker(
                          point: LatLng(
                            widget.stationModel.data.location.coordinates[1],
                            widget.stationModel.data.location.coordinates[0],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<PathBetweenPointsDartCubit>()
                                  .getAllGeometry(
                                coordinates: [
                                  [
                                    userLocation!.longitude,
                                    userLocation!.latitude,
                                  ],
                                  [
                                    widget
                                        .stationModel
                                        .data
                                        .location
                                        .coordinates[0],
                                    widget
                                        .stationModel
                                        .data
                                        .location
                                        .coordinates[1],
                                  ],
                                ],
                                mode: selectedMode,
                              );
                            },
                            child: Icon(
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
            if (showBottom && widget.stationModel != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: DraggableScrollableSheet(
                  controller: sheetController,
                  initialChildSize: 0.3,
                  minChildSize: 0.2,
                  maxChildSize: 0.5,
                  builder: (context, scrollController) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 10),
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
                            widget.stationModel.data.stationName,
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

                              if (widget.stationModel.data != null) {
                                context
                                    .read<PathBetweenPointsDartCubit>()
                                    .getAllGeometry(
                                  coordinates: [
                                    [
                                      userLocation!.longitude,
                                      userLocation!.latitude,
                                    ],
                                    [
                                      widget
                                          .stationModel
                                          .data!
                                          .location
                                          .coordinates[0],
                                      widget
                                          .stationModel
                                          .data!
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
                                arguments: widget.stationModel.data.id,
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
          ],
        ),
      ),
    );
  }
}
