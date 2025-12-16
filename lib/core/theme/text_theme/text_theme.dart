import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../color/colors.dart';
import 'font_weight.dart';

class AppTextStyle {
  static TextStyle font30BlackBold = GoogleFonts.amiri(
    color: AppColors.darkBBlack,
    fontWeight: FontWeightHelper.bold,
    fontSize: 30.sp,
    letterSpacing: 0.7,
  );

  static TextStyle font18WhiteBold = GoogleFonts.amiri(
    color: AppColors.whiteColor,
    fontWeight: FontWeightHelper.bold,
    fontSize: 18.sp,
    letterSpacing: 0.7,
  );

  static TextStyle font40BlackRegular = GoogleFonts.amiri(
    color: AppColors.blackColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 40.sp,
    letterSpacing: 0.7,
  );
  static TextStyle font14GreyRegular = GoogleFonts.amiri(
    color: AppColors.greyColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 14.sp,
    letterSpacing: 0.7,
  );
  static TextStyle font14formGreyColorRegular = GoogleFonts.amiri(
    color: AppColors.formGreyColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 14.sp,
    letterSpacing: 0.7,
  );
  static TextStyle font9BlackRegular = GoogleFonts.amiri(
    color: AppColors.blackColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 9.sp,
    letterSpacing: 0.7,
  );
  static TextStyle font14BlackRegular = GoogleFonts.amiri(
    color: AppColors.blackColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 14.sp,
    letterSpacing: 0.7,
  );
  static TextStyle font18WhiteMedium = GoogleFonts.amiri(
    color: AppColors.whiteColor,
    fontWeight: FontWeightHelper.medium,
    fontSize: 18.sp,
    letterSpacing: 0.7,
  );
  static TextStyle font11RedMedium = GoogleFonts.amiri(
    color: AppColors.redColor,
    fontWeight: FontWeightHelper.medium,
    fontSize: 11.sp,
    letterSpacing: 0.7,
  );
  static TextStyle font11BlackRegular = GoogleFonts.amiri(
    color: AppColors.blackColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 11.sp,
    letterSpacing: 0.7,
  );

  static TextStyle font15GreyRegular = GoogleFonts.amiri(
    color: AppColors.greyColor,
    fontWeight: FontWeightHelper.regular,
    fontSize: 15.sp,
    letterSpacing: 0.7,
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
