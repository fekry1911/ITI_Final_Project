import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/color/colors.dart';

class Dots extends StatelessWidget {
  final int length;
  final int currentIndex;
  const Dots({super.key, required this.length, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 22.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.all(2),
            width: currentIndex == index ? 26 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: currentIndex == index
                  ? AppColors.mainColor
                  : AppColors.greyColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
        ),
      ),
    );
  }
}
