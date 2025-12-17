import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_theme/text_theme.dart';

class RouteDetails extends StatelessWidget {
  RouteDetails({super.key, required this.distance, required this.duration});

  String distance;
  String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(Icons.watch_later_outlined),
            SizedBox(width: 3.w),

            Text(duration,style: AppTextStyle.font14BlackRegular.copyWith(
              fontSize: 10.sp,
              color: Colors.grey.shade600,
            ),),
          ],
        ),
        SizedBox(width: 6.h),

        Row(
          children: [
            Icon(Icons.social_distance,size: 10.r,),
            SizedBox(width: 3.w),

            Text(
              distance,
              style: AppTextStyle.font14BlackRegular.copyWith(
                fontSize: 10.sp,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
