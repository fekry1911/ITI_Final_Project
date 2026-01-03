import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/color/colors.dart';

class ModernCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? borderRadius;
  final double? width;
  final double? height;
  final bool enableAnimation;
  final int elevation; // Added by user in constructor, but needed here.

  const ModernCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
    this.enableAnimation = true,
    required this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
        boxShadow: elevation == 0 ? [] : [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
        border: Border.all(
          color: AppColors.border.withOpacity(0.5),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          child: Padding(
            padding: padding ?? EdgeInsets.all(16.w),
            child: child,
          ),
        ),
      ),
    );

    if (enableAnimation) {
      return card
          .animate()
          .fadeIn(duration: 600.ms, curve: Curves.easeOutQuad)
          .slideY(begin: 0.2, end: 0, duration: 600.ms, curve: Curves.easeOutQuad)
          .scaleXY(begin: 0.95, end: 1.0, duration: 600.ms, curve: Curves.easeOutBack) // Subtle bounce
          .shimmer(duration: 1200.ms, color: Colors.white.withOpacity(0.1), delay: 400.ms); // Dynamic highlight
    }

    return card;
  }
}
