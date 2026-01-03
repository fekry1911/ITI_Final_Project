import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color/colors.dart';
import '../theme/text_theme/text_theme.dart';


class NoTripsWidget extends StatelessWidget {
  final String? message;
  final VoidCallback? onRetry;

  const NoTripsWidget({super.key, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(30.r),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.directions_bus_filled_outlined,
              size: 60.r,
              color: AppColors.textTertiary.withOpacity(0.5),
            ),
          ).animate()
           .scale(duration: 600.ms, curve: Curves.easeOutBack)
           .fadeIn(),
           
          SizedBox(height: 24.h),
          
          Text(
            message ?? "لا توجد رحلات متاحة حالياً",
            style: AppTextStyle.font18BlackBold.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
          
          SizedBox(height: 8.h),
          
          Text(
            "حاول مرة أخرى في وقت لاحق",
            style: AppTextStyle.font14BlackRegular.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(delay: 400.ms),
          
          if (onRetry != null) ...[
            SizedBox(height: 32.h),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("تحديث"),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
