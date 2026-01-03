import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/featuers/stations/screens/search_stations_screen.dart';
import 'package:iti_moqaf/featuers/stations/screens/widgets/station_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/shared_widgets/error_page.dart';
import '../../../core/theme/color/colors.dart';
import '../data/model/data/filter_data.dart';
import '../data/model/data/statuins_data.dart';
import '../data/model/stations_model.dart';
import '../logic/get_all_stations_cubit.dart';
import '../logic/get_all_stations_state.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({super.key});

  @override
  State<StationsScreen> createState() => _StationsscreenState();
}

class _StationsscreenState extends State<StationsScreen> {
  TextEditingController controller = TextEditingController();
  String fillter = filters[0]["label"]!;
  String valueFillter = filters[0]["value"]!;
  List? currentStations;
  ScrollController controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    if (context.read<GetAllStationsCubit>().lastPage !=
        context.read<GetAllStationsCubit>().page) {
      controllerScroll.addListener(() => _getMore());
    }
  }

  void _getMore() {
    if (controllerScroll.position.pixels >=
        controllerScroll.position.maxScrollExtent - 200) {
      context.read<GetAllStationsCubit>().getAllStations();
    }
  }

  @override
  void dispose() {
    controllerScroll.dispose();
    controllerScroll.removeListener(()=>_getMore());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal:4, vertical: 8.0),
            child: TextField(
              readOnly: true,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SearchStationsScreen()),
                );
              },
              decoration: InputDecoration(
                hintText: "ابحث عن محطه",
                hintStyle: TextStyle(color: AppColors.textTertiary),
                prefixIcon: Icon(Icons.search, color: AppColors.textTertiary),
                filled: true,
                fillColor: AppColors.surface,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.border),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          BlocConsumer<GetAllStationsCubit, GetAllStationsState>(
            builder: (BuildContext context, state) {
              var cubit = context.read<GetAllStationsCubit>();
              if (state is GetAllStationsError && state.error != "لا يوجد اتصال بالإنترنت") {
                return NetWorkError(
                  error: state.error,
                  onPressed: () {
                    cubit.getAllStations();
                  },
                );
              }

              List<SimpleStationData> data = state is GetAllStationsLoading
                  ? [
                      SimpleStationData(
                        stationName: "stationName",
                        lines: [],
                        status: "status",
                      ),
                      SimpleStationData(
                        stationName: "stationName",
                        lines: [],
                        status: "status",
                      ),
                      SimpleStationData(
                        stationName: "stationName",
                        lines: [],
                        status: "status",
                      ),
                    ]
                  : state is GetAllStationsSuccess
                  ? state.stations
                  : [];

              return Expanded(
                child: Skeletonizer(
                  ignoreContainers: true,
                  ignorePointers: true,
                  enabled: state is GetAllStationsLoading,
                  child: RefreshIndicator(
                    onRefresh: () {
                      cubit.getAllStations();
                      return Future.delayed(Duration(seconds: 1));
                    },
                    child: ListView.separated(
                      controller: controllerScroll,
                      itemBuilder: (BuildContext context, int index) {
                        return StationCard(data: data[index], index: index);
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 5.h);
                      },
                      itemCount: data.length,
                    ),
                  ),
                ),
              );
            },
            listener: (BuildContext context, state) {},
          ),
        ],
      ),
    );
  }
}
