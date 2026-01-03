import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/theme/text_theme/text_theme.dart';
import '../models/onBoarding_model.dart';

class Pages extends StatelessWidget {
  final OnboardingModel data;

  const Pages({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(data.image, height: 300.h),
        SizedBox(height: 20.h),
        Text(data.title, style: AppTextStyle.font30BlackBold),
        SizedBox(height: 10.h),
        Text(
          data.description,
          style: AppTextStyle.font14GreyRegular,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
