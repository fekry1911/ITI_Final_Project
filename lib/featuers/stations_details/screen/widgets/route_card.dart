import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/stations_details/screen/widgets/route_details.dart';
import '../../../../core/const/const_paths.dart';
import '../../../../core/shared_widgets/modern_card.dart'; // Added Import
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../data/model/station_model.dart';

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
      child: ModernCard(
        elevation: 1,
        padding: EdgeInsets.zero,
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.directions_bus_filled_rounded,
                      color: AppColors.primary,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "إلى $toStationName",
                          style: AppTextStyle.font16BlackBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Icon(Icons.route_rounded, size: 14.r, color: AppColors.textTertiary),
                             SizedBox(width: 4.w),
                            Text(
                              "$distance كم",
                              style: AppTextStyle.font12BlackRegular.copyWith(color: AppColors.textSecondary),
                            ),
                            SizedBox(width: 12.w),
                             Icon(Icons.access_time_rounded, size: 14.r, color: AppColors.textTertiary),
                             SizedBox(width: 4.w),
                            Text(
                              "$duration دقيقة",
                              style: AppTextStyle.font12BlackRegular.copyWith(color: AppColors.textSecondary),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                         BoxShadow(
                          color: AppColors.secondary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      "${data.price} ج.م",
                      style: AppTextStyle.font14BlackBold.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).animate().fadeIn().slideY(begin: 0.1, end: 0, duration: 400.ms),
    );
  }
}
