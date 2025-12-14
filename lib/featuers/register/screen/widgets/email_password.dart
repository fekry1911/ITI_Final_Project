import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/shared_widgets/shared_text_form_field.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

class EmailAndPasswordRegister extends StatefulWidget {
  EmailAndPasswordRegister({super.key});

  @override
  State<EmailAndPasswordRegister> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPasswordRegister> {
  TextEditingController demo = TextEditingController();
  bool erm = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SharedTextFormField(
          controller: demo,
          hintText: " الاسم بالكامل",
          validator: (string) {},
          suffixIcon: Icon(Icons.account_circle),
        ),
        SizedBox(height: 10.h),
        SharedTextFormField(
          controller: demo,
          hintText: "البريد الالكتروني",
          validator: (string) {},
          suffixIcon: Icon(Icons.email),
        ),
        SizedBox(height: 10.h),
        SharedTextFormField(
          controller: demo,
          hintText: "رقم الهاتف",
          validator: (string) {},
          suffixIcon: Icon(Icons.phone_android),
        ),
        SizedBox(height: 10.h),
        SharedTextFormField(
          controller: demo,
          hintText: "كلمه المرور",
          validator: (string) {},
          suffixIcon: Icon(Icons.visibility_off),
        ),
        SizedBox(height: 7.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: erm,
              onChanged: (s) {
                setState(() {
                  erm = s!;
                });
              },
            ),
            Text(
              "عند تحديد هذا المربع، فإنك تقرّ بموافقتك على الشروط والأحكام.",
              style: AppTextStyle.font9BlackRegular.copyWith(
                fontSize: 10.sp
              ),
            ),
          ],
        ),
      ],
    );
  }
}
