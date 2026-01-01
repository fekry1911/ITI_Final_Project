

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/widgets/recent_route_card.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/widgets/search_field.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/shared_widgets/network_error.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../data/model/near_stations_model.dart';
import '../../logic/get_nearby_stations_cubit.dart';

class HomeBottomSheet extends StatelessWidget {
  HomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.1,
      maxChildSize: 0.6,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // Handle
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SearchField(
                  onTap: () {
                    print("Search tapped");
                  },
                  onMicTap: () {
                    print("Mic tapped");
                  },
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Text(
                    "اقرب المواقف",
                    style: AppTextStyle.font24BlackSemiBold.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              BlocBuilder<GetNearbyStationsCubit, GetNearbyStationsState>(
                builder: (context, state) {
                  var cubit = context.read<GetNearbyStationsCubit>();

                  if (state is GetNearbyStationsError) {
                    if (state.error == "لا يوجد اتصال بالإنترنت"||state.error == "") {
                      return Expanded(
                        child: Center(child: Column(
                          children: [
                            NetWorkErrorPage(),
                            Text("لا يوجد اتصال بالإنترنت"),
                            TextButton(
                              onPressed: () {
                                cubit.getNearbyStations();
                              },
                              child: const Text("حاول مره اخري"),
                            ),
                          ],
                        )),
                      );}
                    return Center(
                      child: Column(
                        children: [
                          Text(state.error),
                          TextButton(
                            onPressed: () {
                              cubit.getNearbyStations();
                            },
                            child: const Text("حاول مره اخري"),
                          ),
                        ],
                      ),
                    );
                  }

                  List<NearStationModel> stations = [];
                  Position userPosition = Position(
                    latitude: 30.0444,
                    longitude: 31.2357,
                    timestamp: DateTime.now(),
                    accuracy: 0,
                    altitude: 0,
                    heading: 0,
                    speed: 0,
                    speedAccuracy: 0,
                    altitudeAccuracy: 20,
                    headingAccuracy: 20,
                  );

                  if (state is GetNearbyStationsLoading) {
                    stations = fakeStations;
                    // userPosition يبقى default
                  } else if (state is GetNearbyStationsSuccess) {
                    stations = state.data;
                    userPosition = state.userPosition ?? userPosition;
                  }

                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Skeletonizer(
                        enabled: state is GetNearbyStationsLoading,
                        child: RecentRouteCard(
                          data: stations[index],
                          userPosition: userPosition,
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 10.h);
                    },
                    itemCount: stations.length,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title),
    );
  }
}
final List<NearStationModel> fakeStations = [
  NearStationModel(
    id: '1',
    stationName: 'Station A',
    lines: ['Line 1', 'Line 2'],
    status: 'Open',
    location: StationLocationModel(
      type: 'Point',
      coordinates: [31.2357, 30.0444], // [lng, lat]
    ),
  ),
  NearStationModel(
    id: '2',
    stationName: 'Station B',
    lines: ['Line 2'],
    status: 'Closed',
    location: StationLocationModel(
      type: 'Point',
      coordinates: [31.238, 30.045],
    ),
  ),
  NearStationModel(
    id: '3',
    stationName: 'Station C',
    lines: ['Line 3'],
    status: 'Open',
    location: StationLocationModel(
      type: 'Point',
      coordinates: [31.240, 30.046],
    ),
  ),
];

