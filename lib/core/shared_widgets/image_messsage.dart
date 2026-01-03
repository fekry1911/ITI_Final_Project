import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/theme/color/colors.dart';
import '../theme/text_theme/text_theme.dart';
import 'container_stack.dart';

class ImageAndMessage extends StatelessWidget {
  ImageAndMessage({
    super.key,
    required this.title,
    required this.desc,
    this.image = "assets/animation/login.json",
    this.register = false,
  });

  String title;
  String desc;
  String image;
  bool? register;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedStackHeader(image: image,register: register!),
        Column(
          children: [
            Text(
              title,
              style: AppTextStyle.font40BlackRegularAmiri.copyWith(
                color: AppColors.mainColor,
                letterSpacing: 0.7,
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              desc,
              style: AppTextStyle.font14GreyRegularAmiri.copyWith(
                color: AppColors.blackColor,
                letterSpacing: 0.7,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
