import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecentRouteCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String statusText;
  final Color statusColor;
  final VoidCallback? onTap;

  const RecentRouteCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.statusText = "في المعاد",
    this.statusColor = Colors.green,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
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
            // Left Icon
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.home_rounded, color: Colors.grey.shade600),
            ),

            SizedBox(width: 12.w),

            // Texts
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Status
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                statusText,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: statusColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(width: 8.w),

            // Arrow
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: Colors.grey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}
