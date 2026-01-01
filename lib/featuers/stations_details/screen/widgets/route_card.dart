import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/stations_details/data/model/station_model.dart';
import 'package:iti_moqaf/featuers/stations_details/screen/widgets/route_details.dart';

class RouteCard extends StatelessWidget {
  final LineModel data;

  const RouteCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // Safety checks for nullable fields
    final toStationName = data.toStation?.stationName ?? "غير محدد";
    final distance = data.distance ?? 0;
    final duration = (distance * 0.6).toInt();

    return GestureDetector(
      onTap: () {
        context.pushNamed(
          lineScreen,
          arguments: {
            "lineId": data.id,
            "stationId": data.fromStation.id, // Use id if available: data.fromStationId
          },
        );
      },
      child: Card(
        elevation: 1,
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: AppColors.greyColor.withOpacity(.1),
            radius: 30,
            child: Icon(
              Icons.route,
              color: AppColors.greyColor.withOpacity(.7),
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              toStationName,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.font14BlackRegular,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      RouteDetails(
                        distance: "$distance كم",
                        duration: "$duration دقيقه",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 5.h,
                      horizontal: 3.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.lightGreen,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      "${data.price} EGP",
                      style: AppTextStyle.font18WhiteMedium.copyWith(
                        fontSize: 10.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().scaleXY(duration: 500.ms),
    );
  }
}
