import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/helpers/cach_helper.dart';
import '../../../core/theme/color/colors.dart';
import '../../../core/theme/text_theme/text_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    final bool isOnboardingDone =
        CacheHelper.getBoolean(key: "onBoarding_finish") ?? false;

    Future.delayed(const Duration(milliseconds: 9000), () {
      if (!mounted) return;

      if (isOnboardingDone) {
        Navigator.pushReplacementNamed(context, homeScreen);
      } else {
        Navigator.pushReplacementNamed(context, onBoarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background subtle gradient or design element could go here
            
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Animation
                Container(
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.1),
                        blurRadius: 30,
                        spreadRadius: 10,
                      )
                    ]
                  ),
                  child: Lottie.asset(
                    "assets/animation/BusSplash.json",
                    width: 180.w,
                    height: 180.h,
                    fit: BoxFit.contain,
                  ),
                )
                .animate()
                .scale(duration: 800.ms, curve: Curves.easeOutBack)
                .fadeIn(duration: 500.ms),

                SizedBox(height: 32.h),

                // App Name / Slogan
                Column(
                  children: [
                     Text(
                      "ITI Moqaf", // Optionally replace with Logo Type if available
                       style: AppTextStyle.font30BlackBold.copyWith(
                        color: AppColors.primary,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.2,
                      ),
                    ).animate()
                     .fadeIn(delay: 600.ms, duration: 600.ms)
                     .slideY(begin: 0.2, end: 0, delay: 600.ms, duration: 600.ms),
                    
                    SizedBox(height: 8.h),
                    
                    Text(
                      "لو تايه احنا ندلّك",
                      style: AppTextStyle.font18BlackBold.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate()
                     .fadeIn(delay: 1000.ms, duration: 600.ms),
                  ],
                ),
              ],
            ),

            // Bottom loading indicator or version info
            Positioned(
              bottom: 48.h,
              child: SizedBox(
                width: 40.w,
                height: 40.w,
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 3,
                ),
              ).animate(onPlay: (c) => c.repeat())
               .fadeIn(delay: 1500.ms),
            ),
          ],
        ),
      ),
    );
  }
}


/*
* Stack(
        children: [

        ],
      )*/
