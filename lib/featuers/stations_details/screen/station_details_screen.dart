import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/stations_details/logic/get_one_station_cubit.dart';
import 'package:iti_moqaf/featuers/stations_details/screen/widgets/route_card.dart';
import 'package:iti_moqaf/featuers/stations_details/screen/widgets/station_info.dart';

class StationDetailsScreen extends StatelessWidget {
  final String stationId;

  const StationDetailsScreen({super.key, required this.stationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.whiteColor,
        title: BlocBuilder<GetOneStationCubit, GetOneStationState>(
          builder: (context, state) {
            var cubit = context.read<GetOneStationCubit>();
            if (state is GetOneStationSuccess) {
              return Text(
                state.stationModel.data.stationName,
                style: AppTextStyle.font14GreyRegular.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              );
            }

            return SizedBox.shrink();
          },
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.popScreen();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: .3.sh,
            decoration: BoxDecoration(),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
              child: Image.network(
                "https://img.youm7.com/ArticleImgs/2025/4/12/756018-%D9%85%D9%88%D9%82%D9%81-%D8%A7%D9%84%D8%B3%D9%84%D8%A7%D9%85-%D8%A7%D9%84%D8%AC%D8%AF%D9%8A%D8%AF-(6).jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.h),
            child: Column(
              children: [
                SizedBox(height: 10.h),
                StationInfo(),
                SizedBox(height: 90.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الخطوط المتاحه",
                      style: AppTextStyle.font24BlackSemiBold,
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                BlocBuilder<GetOneStationCubit, GetOneStationState>(
                  builder: (context, state) {
                    var cubit = context.read<GetOneStationCubit>();
                    if (state is GetOneStationError) {
                      return Center(child: Text(state.error));
                    } else if (state is GetOneStationSuccess &&
                        state.stationModel.data.lines.isNotEmpty) {
                      return Expanded(
                        child: ListView.separated(
                          itemBuilder: (BuildContext context, int index) {
                            return RouteCard(
                              data: state.stationModel.data.lines[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(height: 7.h);
                          },
                          itemCount: state.stationModel.data.lines.length,
                        ),
                      );
                    } else if (state is GetOneStationLoading) {
                      return Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    } else {
                      return Expanded(
                        child: Center(
                          child: Text(
                            "لا يوجد خطوط ف هذه المحطه",
                            style: AppTextStyle.font24BlackSemiBold.copyWith(
                              fontSize: 20.sp,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
