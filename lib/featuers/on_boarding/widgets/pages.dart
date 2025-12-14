import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/onBoarding_pages.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/on_boarding/models/onBoarding_model.dart';
import 'package:iti_moqaf/featuers/on_boarding/widgets/dots.dart';
import 'package:lottie/lottie.dart';

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
          style: AppTextStyle.font18GreyRegular,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
