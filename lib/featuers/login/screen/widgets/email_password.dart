import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/shared_widgets/shared_text_form_field.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';

import '../../../../core/theme/color/colors.dart';

class EmailAndPassword extends StatefulWidget {
  EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  TextEditingController demo = TextEditingController();
  bool erm = false;

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = context.read<LoginCubit>();
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (BuildContext context, state) => Form(
        key: cubit.formKey,
        child: Column(
          children: [
            SharedTextFormField(
              controller: cubit.emailController,
              hintText: "البريد الالكتروني",
              validator: (string) {
                if (string!.isEmpty) {
                  return "البريد الالكتروني مطلوب";
                }
                return null;
              },
              suffixIcon: Icon(Icons.email),
            ),
            SizedBox(height: 10.h),
            SharedTextFormField(
              controller: cubit.passwordController,
              hintText: "كلمه المرور",
              validator: (string) {
                if (string!.isEmpty) {
                  return "كلمة المرور مطلوبة";
                }
                return null;
              },
              suffixIcon: Icon(Icons.visibility_off),
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                Checkbox(
                  value: erm,
                  onChanged: (s) {
                    setState(() {
                      erm = s!;
                    });
                  },
                ),
                Text("تذكرني", style: AppTextStyle.font9BlackRegular),
                Spacer(),
                Text(
                  "نسيت كلمة المرور؟",
                  style: AppTextStyle.font9BlackRegular.copyWith(
                    color: AppColors.redColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
