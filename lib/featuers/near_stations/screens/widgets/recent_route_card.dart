import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import '../../../../core/const/const_paths.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../data/model/near_stations_model.dart';

class RecentRouteCard extends StatelessWidget {


  RecentRouteCard({required this.data, required this.userPosition});
  NearStationModel data;
  Position userPosition;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.pushNamed(stationDetailsScreen, arguments: data.id);
      },
      child: Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Left Icon
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.home_rounded, color: Colors.grey.shade600),
              ),

              SizedBox(width: 12.w),

              // Texts
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.stationName, // data.stationName
                      style: AppTextStyle.font14BlackRegular
                    ),
                    SizedBox(height: 4.h),
                    Builder(
                      builder: (context) {
                        double distanceInMeters = Geolocator.distanceBetween(
                          userPosition.latitude,
                          userPosition.longitude,
                          data.location.coordinates[1], // Latitude (assuming index 1 for MongoDB)
                          data.location.coordinates[0], // Longitude
                        );
                        String distanceText;
                        if (distanceInMeters < 1000) {
                          distanceText = "${distanceInMeters.toStringAsFixed(0)} متر";
                        } else {
                          distanceText = "${(distanceInMeters / 1000).toStringAsFixed(2)} كم";
                        }
                        
                        return Text(
                          distanceText,
                          style: AppTextStyle.font14BlackRegular.copyWith(
                            fontSize: 9.sp,
                            color: Colors.grey.shade600
                          )
                        );
                      }
                    ),
                  ],
                ),
              ),

              // Status
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  data.status, // data.status
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Arrow
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14.sp,
                color: Colors.grey.shade400,
              ),
            ],
          ),
      ),
    ); // Removed .animate()
  }
}
