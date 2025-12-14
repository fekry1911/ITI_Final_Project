import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../color/colors.dart';
import 'font_weight.dart';

class AppTextStyle {
  static TextStyle font30BlackBold = TextStyle(
    color: AppColors.darkBBlack,
    fontWeight: FontWeightHelper.bold,
    fontSize: 30.sp,
  );
  static TextStyle font24BlackSemiBold = TextStyle(
    color: AppColors.darkBBlack,
    fontWeight: FontWeightHelper.semiBold,
    fontSize: 24.sp,
  );
  static TextStyle font18GreyRegular = TextStyle(
    color: AppColors.greyColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 14.sp,
  );
}
