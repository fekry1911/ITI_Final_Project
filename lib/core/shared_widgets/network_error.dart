import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:lottie/lottie.dart';

import '../theme/color/colors.dart';

class NetWorkErrorPage extends StatelessWidget {
  const NetWorkErrorPage({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset('assets/animation/network_error.json',width: double.infinity,height: 200.h,fit: BoxFit.contain),
          SizedBox(height: 10.h),
         Text('Retry', style: AppTextStyle.font14GreyRegular.copyWith(color: AppColors.whiteColor)),

        ],
      ),
    );
  }
}
