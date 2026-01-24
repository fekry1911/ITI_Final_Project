import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/const/const_paths.dart';
import '../../../../core/shared_widgets/modern_card.dart'; // Added Import
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../data/model/stations_model.dart';

class StationCard extends StatelessWidget {
  StationCard({
    super.key,
    required this.data,
    required this.index,
    this.userPosition,
  });

  SimpleStationData data;
  int index;
  Position? userPosition;

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      // Use ModernCard
      padding: EdgeInsets.zero,

      // ListTile has its own padding usually, or we control it here
      onTap: () {
        Navigator.pushNamed(context, stationDetailsScreen, arguments: data.id);
      },
      elevation: 0,
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: data.status != "Issues"
            ? CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(
                  .1,
                ), // refined opacity
                radius: 22.r,
                child: Icon(
                  Icons.directions_bus,
                  // Changed icon to bus/train as appropriate, keeping consistent
                  color: AppColors.primary,
                  size: 22.r,
                ),
              )
            : CircleAvatar(
                backgroundColor: AppColors.textSecondary.withOpacity(.1),
                radius: 30.r,
                child: Icon(
                  Icons.build_sharp,
                  color: AppColors.textSecondary.withOpacity(.7),
                  size: 25.r,
                ),
              ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    data.stationName!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.font14BlackRegular.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
                SizedBox(width: 6.w),
                Icon(
                  Icons.circle,
                  size: 10.r,
                  color: data.status == "Issues"
                      ? AppColors.error
                      : AppColors.success, // Use AppColors
                ),
              ],
            ),
            SizedBox(height: 5.h),
            data.status == "Issues"
                ? Text(
                    "مغلق للصيانه",
                    style: AppTextStyle.font14BlackRegular.copyWith(
                      color: AppColors.error,
                      fontSize: 12.sp,
                    ),
                  )
                : Row(
                    children: [
                      Builder(
                        builder: (context) {
                          if (userPosition != null &&
                              data.location != null &&
                              data.location!.coordinates.length >= 2) {
                            double distanceInMeters =
                                Geolocator.distanceBetween(
                                  userPosition!.latitude,
                                  userPosition!.longitude,
                                  data.location!.coordinates[1], // Lat
                                  data.location!.coordinates[0], // Long
                                );

                            String distanceText;
                            if (distanceInMeters < 1000) {
                              distanceText =
                                  "علي بعد ${distanceInMeters.toStringAsFixed(0)} متر";
                            } else {
                              distanceText =
                                  "علي بعد ${(distanceInMeters / 1000).toStringAsFixed(2)} كم";
                            }
                            return Text(
                              distanceText,
                              style: AppTextStyle.font14BlackRegular.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 12.sp,
                              ),
                            );
                          }
                          return Text(
                            "المسافة غير معروفة",
                            style: AppTextStyle.font14BlackRegular.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12.sp,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        child: Text(
                          "${data.lines.length} الخطوط",
                          style: AppTextStyle.font11BlackRegular.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.textTertiary,
          size: 18.r,
        ),
      ),
    );
  }
}
