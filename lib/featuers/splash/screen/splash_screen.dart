import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../../../core/const/const_paths.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 9000), () => context.pushNamed(loginScreen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         Center(
           child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.center,
             children: [
               SizedBox(
                 child: Lottie.asset("assets/animation/BusSplash.json"),
               ).animate().scaleXY(delay: 4000.ms, duration: 1500.ms),
               Text("لو تايه احنا ندلّك",style: AppTextStyle.font30BlackBold.copyWith(
                 color: AppColors.mainColor
               ),
               ).animate().fadeIn(delay: 4000.ms, duration: 2000.ms),
             ],
           ),
         ),
          Expanded(
            child: Column(
              children: [
                Expanded(child: Container(color: AppColors.mainColor)).animate().moveY(delay:3000.ms, begin: 0.w, end: -1000.w, duration: 2500.ms),
                Expanded(child: Container(color: AppColors.mainColor)).animate().moveY(delay:3000.ms,begin: 0.w, end: 1000.w, duration: 2500.ms),
              ],
            ),
          ),
          Center(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Lottie.asset(
                "assets/animation/bus2.json",
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(
                      ['**'],
                      value: Colors.white,
                    ),
                  ],
                ),
              ),
            ).animate().scaleXY( duration: 1500.ms).moveX(
              delay: 2000.ms,
              begin: 0,
              end: 1000.w,
              duration: 2000.ms
            ),
          ),
        ],
      ),
    );
  }
}

/*
* Stack(
        children: [

        ],
      )*/
