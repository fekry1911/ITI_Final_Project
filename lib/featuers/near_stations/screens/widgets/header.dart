import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 50.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.whiteColor.withOpacity(0.6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(Icons.directions_bus, size: 24, color: AppColors.blackColor),
              radius: 24,
              backgroundColor: AppColors.mainColor.withOpacity(0.1),
            ),
            SizedBox(width: 12.w),

            Expanded(
              child: Text(" اضغط لعرض اقرب المحطات", style: AppTextStyle.font18BlackBold.copyWith(
                fontSize: 14.sp
              )),
            ),
          ],
        ),
      ),
    );
  }
}
