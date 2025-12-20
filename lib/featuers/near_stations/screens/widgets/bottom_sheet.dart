import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/near_stations/logic/get_nearby_stations_cubit.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/widgets/recent_route_card.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/widgets/search_field.dart';

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
                  Spacer(),
                  InkWell(
                    onTap: () {
                      context.pushNamed(stationsScreen);
                    },
                    child: Text(
                      "عرض الكل",
                      style: AppTextStyle.font18GreyRegular.copyWith(
                        color: AppColors.mainColor,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

             BlocBuilder<GetNearbyStationsCubit, GetNearbyStationsState>(
                builder: (context, state) {
                  var cubit = context.read<GetNearbyStationsCubit>();
                  if (state is GetNearbyStationsSuccess) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return RecentRouteCard(
                          data: state.data[index],
                          userPosition: state.userPosition,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10.h);
                      },
                      itemCount: state.data.length,
                    );
                  } else if (state is GetNearbyStationsError) {
                    return Center(
                      child: Column(
                        children: [
                          Text(state.error),
                          TextButton(
                            onPressed: () {
                              cubit.getNearbyStations();
                            },
                            child: Text("حاول مره اخري"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
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
