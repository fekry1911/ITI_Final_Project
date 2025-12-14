import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

class ButtonDoneRegister extends StatelessWidget {
  const ButtonDoneRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230.w,
      height: 40.h,

      child: MaterialButton(
        onPressed: () {
          context.pushNamed(loginScreen);
        },
        child: Text("ابدأ الآن", style: AppTextStyle.font18WhiteMedium),
        color: AppColors.blackColor,
        splashColor: AppColors.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
    );
  }
}
