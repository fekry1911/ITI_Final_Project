import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color/colors.dart';
import '../theme/text_theme/text_theme.dart';

class SharedTextFormField extends StatelessWidget {
  const SharedTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.suffixIcon,
    this.prefixIcon,
    this.fillColor,
    this.borderRadius = 16,
    this.onTap,
    this.onChanged,
  });

  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? fillColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final void Function(String)? onChanged;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      obscuringCharacter: "●",
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      cursorColor: AppColors.primary,
      onTap: onTap,
      style: AppTextStyle.font15GreyRegular.copyWith(
        letterSpacing: obscureText ? 2.5 : null,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textTertiary),
        filled: true,
        fillColor: fillColor ?? AppColors.surface, // Use surface color by default
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorMaxLines: 2,
        errorStyle: TextStyle(
          color: AppColors.error,
          fontSize: 12.sp,
        ),
        // By removing explicit border definitions here, we allow the main.dart ThemeData to take effect.
        // If we want to support custom borderRadius passing, we can do:
        enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(borderRadius.r),
           borderSide: BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(borderRadius.r),
           borderSide: BorderSide(color: AppColors.primary, width: 2),
         ),
        errorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(borderRadius.r),
           borderSide: BorderSide(color: AppColors.error),
         ),
        focusedErrorBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(borderRadius.r),
           borderSide: BorderSide(color: AppColors.error, width: 2),
         ),
      ),
    );
  }
}
