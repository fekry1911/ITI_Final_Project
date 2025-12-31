import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/text_theme/text_theme.dart';

Widget buildButton({
  required String text,
  required Color color,
  required VoidCallback onTap,
}) {
  return ElevatedButton(
    onPressed: onTap,
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
    ),
    child: Text(
      text,
      style: AppTextStyle.font11RedMedium.copyWith(
        color: Colors.white,
        fontSize: 9.sp,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
