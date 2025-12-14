import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/shared_widgets/shared_text_form_field.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

import '../../../../core/theme/color/colors.dart';

class EmailAndPassword extends StatefulWidget {
  EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  TextEditingController demo = TextEditingController();
  bool erm=false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedTextFormField(
          controller: demo,
          hintText: "البريد الالكتروني",
          validator: (string) {},
          suffixIcon: Icon(Icons.email),
        ),
        SizedBox(height: 10.h),
        SharedTextFormField(
          controller: demo,
          hintText: "كلمه المرور",
          validator: (string) {},
          suffixIcon: Icon(Icons.visibility_off),
        ),
        SizedBox(height: 7.h),
        Row(children: [
          Checkbox(value: erm, onChanged: (s){
            setState(() {
              erm=s!;
            });
          }),
          Text("تذكرني",style: AppTextStyle.font9BlackRegular,),
          Spacer(),
          Text("نسيت كلمة المرور؟",style: AppTextStyle.font9BlackRegular.copyWith(
            color: AppColors.redColor
          ),),
        ]),
      ],
    );
  }
}
