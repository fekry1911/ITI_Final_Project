import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../theme/color/colors.dart';

class NetWorkError extends StatelessWidget {
  const NetWorkError({super.key, required this.onPressed, required this.error});

  final void Function() onPressed;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset('assets/animation/NetWorkError.json',width: double.infinity,height: 200.h,fit: BoxFit.contain),
          SizedBox(height: 10.h),
          Text(error),
          SizedBox(height: 10.h),
          MaterialButton(
            color: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            onPressed: onPressed,
            child: Text('Retry', style: AppTextStyle.font14GreyRegular.copyWith(color: AppColors.whiteColor)),
          ),
        ],
      ),
    );
  }
}
