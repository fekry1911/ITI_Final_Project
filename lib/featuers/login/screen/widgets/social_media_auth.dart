import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

class SocialMediaAuth extends StatelessWidget {
  const SocialMediaAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/divider.png"),
            SizedBox(width: 9.w),
            Text("أو", style: AppTextStyle.font14BlackRegular),
            SizedBox(width: 9.w),
            Image.asset("assets/images/divider.png"),
          ],
        ),
        SizedBox(height: 14.w),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.h,
              width: 35.w,
              child: Image.asset("assets/images/face.png", fit: BoxFit.contain),
            ),
            SizedBox(width: 20.w),
            SizedBox(
              height: 35.h,
              width: 35.w,
              child: Image.asset(
                "assets/images/google.png",
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
