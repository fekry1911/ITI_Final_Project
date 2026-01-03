import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';

class FilterWidget extends StatelessWidget {
   FilterWidget({super.key,required this.text,required this.backColor,required this.textColor});
  String text;
  Color backColor;
  Color textColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical:7.h,horizontal: 15.w),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2) ,blurRadius: 5.r,spreadRadius: 2.r)
        ],
        color: backColor,
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      child: Text(text,style: AppTextStyle.font14BlackRegular.copyWith(
        color: textColor
      ),textAlign:TextAlign.center,),
    );
  }
}
