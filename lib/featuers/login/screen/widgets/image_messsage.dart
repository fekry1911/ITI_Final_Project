import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:lottie/lottie.dart';

class ImageAndMessage extends StatelessWidget {
  const ImageAndMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 173.h,
          width: double.infinity,
          child: Lottie.asset("assets/animation/login.json"),
        ),
        Text("مرحبا بعودتك", style: AppTextStyle.font40BlackRegular),
        SizedBox(height: 10.h),
        Text(
          "قم بتسجيل الدخول للوصول إلى حسابك",
          style: AppTextStyle.font14GreyRegular,
        ),
      ],
    );
  }
}
