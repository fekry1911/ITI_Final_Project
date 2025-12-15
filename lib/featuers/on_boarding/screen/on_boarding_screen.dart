import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/const/onBoarding_pages.dart';
import 'package:iti_moqaf/featuers/on_boarding/widgets/buttons.dart';
import 'package:iti_moqaf/featuers/on_boarding/widgets/dots.dart';
import 'package:iti_moqaf/featuers/on_boarding/widgets/pages.dart';
import 'package:iti_moqaf/featuers/on_boarding/widgets/skip_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});
TextEditingController demo=TextEditingController();
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  Future<void> finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("onBoarding_finish", true);
    if (!mounted) return;
    Navigator.pushNamed(context, home);
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
                  alignment: Alignment.centerRight,
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
