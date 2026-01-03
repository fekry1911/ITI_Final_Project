import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/color/colors.dart';

class Buttons extends StatelessWidget {
  final bool? isLastPage;
  final bool? isFirstPage;

  final VoidCallback? onNext;
  final VoidCallback? onPrev;

  final IconData icon;
  final Alignment alignment;
  const Buttons({
    super.key,
    this.isLastPage,
    this.onNext,
    required this.icon,
    required this.alignment,
    this.isFirstPage,
    this.onPrev,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColor,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          ),
          onPressed: onNext,
          child: Icon(icon, color: Colors.white, size: 24),
        ),
      ),
    );
  }
}
