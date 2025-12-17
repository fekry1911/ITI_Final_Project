import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color/colors.dart';

void errorToast(context, String title,String desc) {
  CherryToast.error(
    toastPosition: Position.bottom,
    animationType: AnimationType.fromTop,
    backgroundColor: AppColors.redColor.withOpacity(0.1),
    animationDuration: Duration(seconds: 2),
    description: Text(desc, style: TextStyle(color: Colors.black)),
    title: Text(title, style: TextStyle(color: Colors.white,fontSize: 16.sp)),
  ).show(context);
}
void sucssesToast(context, String title,String desc) {
  CherryToast.success(
    toastPosition: Position.bottom,
    animationType: AnimationType.fromTop,
    backgroundColor: Colors.green.withOpacity(0.1),
    animationDuration: Duration(seconds: 2),
    description: Text(desc, style: TextStyle(color: Colors.black)),
    title: Text(title, style: TextStyle(color: Colors.white,fontSize: 16.sp)),
  ).show(context);
}