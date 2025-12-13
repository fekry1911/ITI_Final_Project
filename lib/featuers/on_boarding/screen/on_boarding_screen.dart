import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:Text("On Boarding Screen",style: AppTextStyle.font30BlackBold,)
      ),
    );
  }
}
