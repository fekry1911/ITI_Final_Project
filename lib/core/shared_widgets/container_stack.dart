import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:lottie/lottie.dart';

import '../theme/color/colors.dart';

class SharedStackHeader extends StatelessWidget {
   SharedStackHeader({super.key,required this.image,this.register=false});
  String image;
  bool register;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: .33.sh,
            width: 1.sw,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50.r),
                  bottomRight: Radius.circular(50.r),
                )
            )
        ),


        SizedBox(
          width: double.infinity,
          child: Lottie.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: .33.sh,
          ),
        ).animate().scaleXY(duration: 2000.ms),
      register ?  Positioned(
          top: 25.h,
          child: IconButton(
            onPressed: () {
              print("Done");
              context.popScreen();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.whiteColor,
            ),
          ),
        ):SizedBox.shrink(),
      ],
    );
  }
}
