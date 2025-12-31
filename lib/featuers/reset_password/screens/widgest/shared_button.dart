import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

import '../../../../core/theme/color/colors.dart';

class SharedButton extends StatelessWidget {
  const SharedButton({super.key, required this.onTap, required this.text, this.isLoading=false});
  final void Function()? onTap;
  final String text;
  final bool isLoading ;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColor,
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child:isLoading?Center(child: CircularProgressIndicator(color: AppColors.whiteColor,),): Text(text, style: AppTextStyle.font18WhiteBold),
    );

  }
}
