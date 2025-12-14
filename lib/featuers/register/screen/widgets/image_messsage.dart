import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/color/colors.dart';

class ImageAndMessageRegister extends StatelessWidget {
  const ImageAndMessageRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h),

        SizedBox(
          height: 150.h,
          width: double.infinity,
          child: Lottie.asset("assets/animation/signUp.json"),
        ).animate().scaleXY(duration: 2000.ms),
        SizedBox(height: 20.h),

        Text(
          "ابدأ الآن",
          style: AppTextStyle.font40BlackRegular.copyWith(
            color: AppColors.whiteColor,
            letterSpacing: 0.7,
          ),
        ),
        SizedBox(height: 3.h),
        Text(
          "من خلال إنشاء حساب مجاني",
          style: AppTextStyle.font14GreyRegular.copyWith(
            color: AppColors.strongGrey,
            letterSpacing: 0.7,
          ),
        ),
      ],
    );
  }
}
