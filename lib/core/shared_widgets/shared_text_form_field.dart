import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color/colors.dart';
import '../theme/text_theme/text_theme.dart';

class SharedTextFormField extends StatelessWidget {
  SharedTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.obscureText = false,
    this.onTap,
    this.shown = false,
    this.suffixIcon = const SizedBox.shrink(),
    this.prefixIcon = const SizedBox.shrink(),
    this.fillColor,
    this.boderRaduis,
  });

  String hintText;
  String? Function(String?)? validator;
  bool obscureText;
  void Function()? onTap;
  bool shown;
  TextEditingController controller;
  Widget suffixIcon;
  Widget prefixIcon;
  Color? fillColor;
  double? boderRaduis;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      cursorColor: AppColors.redColor,
      style: AppTextStyle.font15GreyRegular,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.blackColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.redColor),
        ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.blackColor),
          ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.blackColor),
        ),
        errorStyle: TextStyle(color: AppColors.redColor, fontSize: 12.sp),
        errorMaxLines: 2,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
        hintText: hintText,
        fillColor: fillColor ?? AppColors.formGreyColor,
        filled: true,
        enabled: true,
      ),
    );
  }
}
