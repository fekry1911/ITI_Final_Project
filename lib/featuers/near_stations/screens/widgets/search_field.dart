import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color/colors.dart';

class SearchField extends StatelessWidget {
  final String hintText;
  final VoidCallback? onTap;
  final VoidCallback? onMicTap;

  const SearchField({
    super.key,
    this.hintText = "رايح فين؟ مثال: محطة رمسيس",
    this.onTap,
    this.onMicTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Search Icon
            Icon(Icons.search, color: AppColors.mainColor, size: 22.sp),

            SizedBox(width: 12.w),

            // Hint Text
            Expanded(
              child: Text(
                hintText,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
              ),
            ),

            SizedBox(width: 8.w),

            // Mic Icon
            GestureDetector(
              onTap: onMicTap,
              child: Icon(
                Icons.mic_none_rounded,
                color: Colors.grey.shade600,
                size: 22.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
