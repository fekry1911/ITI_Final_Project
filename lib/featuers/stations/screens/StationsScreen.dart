import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/shared_widgets/shared_text_form_field.dart';
import 'package:iti_moqaf/featuers/stations/logic/get_all_stations_cubit.dart';
import 'package:iti_moqaf/featuers/stations/screens/widgets/filter_widget.dart';
import 'package:iti_moqaf/featuers/stations/screens/widgets/station_card.dart';

import '../../../core/theme/color/colors.dart';
import '../data/model/data/filter_data.dart';
import '../data/model/data/statuins_data.dart';
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

  @override
  void initState() {
    super.initState();
    currentStations = stationsData;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SharedTextFormField(
              controller: controller,
              hintText: "ابحث عن محطه",
              validator: (x) {
                return null;
              },
              boderRaduis: 30.r,
              fillColor: AppColors.whiteColor,
              prefixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 40.h,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: filters.length,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                String label = filters[index]["label"]!;
                String value = filters[index]["value"]!;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      fillter = label;
                      valueFillter = value;

                      if (valueFillter == "All") {
                        currentStations = stationsData;
                      } else {
                        currentStations = stationsData
                            .where(
                              (station) => station["status"] == valueFillter,
                            )
                            .toList();
                      }
                    });
                  },
                  child: FilterWidget(
                    text: label,
                    backColor: fillter == label
                        ? AppColors.mainColor.withOpacity(.7)
                        : AppColors.whiteColor,
                    textColor: fillter == label
                        ? AppColors.whiteColor
                        : AppColors.blackColor,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.h),
          BlocConsumer<GetAllStationsCubit, GetAllStationsState>(
            builder: (BuildContext context, state) {
              var cubit = context.read<GetAllStationsCubit>();
              if (state is GetAllStationsError) {
                return Center(child: Text(state.error));
              }
              if (state is GetAllStationsSuccess) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return StationCard(
                        data: state.stations[index],
                        index: index,
                        userPosition: state.userPosition,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(height: 5.h);
                    },
                    itemCount: state.stations.length,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
            listener: (BuildContext context, state) {},
          ),
        ],
      ),
    );
  }
}
