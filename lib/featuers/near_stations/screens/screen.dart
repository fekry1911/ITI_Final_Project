import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/widgets/bottom_sheet.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/widgets/header.dart';
import '../../../core/di/di.dart';
import '../../map/presentation/screen/map.dart';
import '../logic/get_nearby_stations_cubit.dart';

class NearStations extends StatefulWidget {
  const NearStations({super.key});

  @override
  State<NearStations> createState() => _NearStationsState();
}

class _NearStationsState extends State<NearStations> {
  late GetNearbyStationsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<GetNearbyStationsCubit>()..getNearbyStations();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return BlocProvider.value(
            value: _cubit,
            child: HomeBottomSheet(),
          );
        },
      );
    });
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocProvider.value(
        value: _cubit,
        child: Stack(
          children: [
            MapSample(),
            /* ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Image.network(
              "https://developers.google.com/static/maps/documentation/tile/images/example-basemap-tile.png",
              height: 1.sh,
              fit: BoxFit.fill,
            ),
          ),*/
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  barrierColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return BlocProvider.value(
                      value: _cubit,
                      child: HomeBottomSheet(),
                    );
                  },
                );
              },
              child: Header(),
            ),
          ],
        ),
      ),
    );
  }
}
