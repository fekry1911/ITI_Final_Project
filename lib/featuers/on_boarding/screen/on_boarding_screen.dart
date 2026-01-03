import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/const/onBoarding_pages.dart';
import '../../../core/helpers/cach_helper.dart';
import '../widgets/buttons.dart';
import '../widgets/dots.dart';
import '../widgets/pages.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  Future<void> finishOnboarding() async {
    CacheHelper.putBoolean(key: "onBoarding_finish", value: true);
    if (!mounted) return;
    Navigator.pushNamed(context, homeScreen);
  }

  void nextPage() {
    if (currentIndex == onboardingData.length - 1) {
      finishOnboarding();
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: 30.h),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),

            child: Column(
              children: [
                // SkipButton(onSkip: finishOnboarding),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (index) => {
                      setState(() {
                        currentIndex = index;
                      }),
                    },
                    itemBuilder: (context, index) {
                      return Pages(data: onboardingData[index]);
                    },
                  ),
                ),
                Dots(length: onboardingData.length, currentIndex: currentIndex),
                SizedBox(height: 30.h),

                Buttons(
                  isLastPage: currentIndex == onboardingData.length - 1,
                  icon: Icons.arrow_forward_ios_rounded,
                  alignment: Alignment.centerLeft,
                  onNext: nextPage,
                ),
                // Buttons(
                //   icon: Icons.arrow_back_ios_new_outlined,
                //   alignment: Alignment.centerLeft,
                //   isFirstPage: currentIndex == 0,
                //   onPrev: () {},
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
