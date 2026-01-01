import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/shared_widgets/error_page.dart';
import 'package:iti_moqaf/featuers/stations/logic/search_stations_cubit.dart';
import 'package:iti_moqaf/featuers/stations/screens/widgets/station_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/di/di.dart';
import '../data/model/stations_model.dart';
import '../../../core/networking/api_service.dart';
import '../data/model/repo/get_all_stations-repo.dart';

class SearchStationsScreen extends StatelessWidget {
  const SearchStationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchStationsCubit(
        GetAllStationsRepo(getIt<ApiService>()),
      )..getAllStations(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("بحث عن محطة"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Column(
            children: [
              Builder(
                builder: (context) {
                  return TextField(
                    onChanged: (value) {
                      context.read<SearchStationsCubit>().search(value);
                    },
                    decoration: InputDecoration(
                      hintText: "ابحث عن محطه",
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
              ),
              SizedBox(height: 10.h),
              Expanded(
                child: BlocBuilder<SearchStationsCubit, SearchStationsState>(
                  builder: (context, state) {
                    if (state is SearchStationsError) {
                       return NetWorkError(
                          error: state.message,
                          onPressed: () {
                             context.read<SearchStationsCubit>().getAllStations();
                          },
                        );
                    }

                    List<SimpleStationData> data = [];
                    bool isLoading = true;

                    if (state is SearchStationsLoaded) {
                      data = state.stations;
                      isLoading = false;
                    } else if (state is SearchStationsLoading) {
                       // Show dummy data for skeleton
                       data = List.generate(5, (index) => SimpleStationData(
                         stationName: "Loading Station",
                         lines: [],
                         status: "Active",
                       ));
                    }

                    return Skeletonizer(
                      enabled: isLoading,
                      child: ListView.separated(
                        itemBuilder: (context, index) {
                          return StationCard(data: data[index], index: index);
                        },
                        separatorBuilder: (context, index) => SizedBox(height: 5.h),
                        itemCount: data.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
