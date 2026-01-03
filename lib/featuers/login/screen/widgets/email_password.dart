import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import '../../../../core/const/const_paths.dart';
import '../../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../logic/login_cubit.dart';

class EmailAndPassword extends StatelessWidget {
  EmailAndPassword({super.key});


  ValueNotifier<bool> showPassword = ValueNotifier(false);

  ValueNotifier<bool> checkTerms = ValueNotifier(false);

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
            ValueListenableBuilder(
              valueListenable: showPassword,
              builder: (BuildContext context, value, Widget? child) {
                return SharedTextFormField(
                  obscureText: showPassword.value,
                  controller: cubit.passwordController,
                  hintText: "كلمه المرور",
                  validator: (string) {
                    if (string!.isEmpty) {
                      return "كلمة المرور مطلوبة";
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    onPressed: () {
                      showPassword.value = !showPassword.value;
                    },
                    icon: Icon(showPassword.value?Icons.visibility: Icons.visibility_off),
                  ),
                );
              },
            ),
            SizedBox(height: 7.h),
            Row(
              children: [
                ValueListenableBuilder(valueListenable: checkTerms, builder: (BuildContext context, value, Widget? child) {
                  return  Checkbox(
                    value: checkTerms.value,
                    onChanged: (s) {
                     checkTerms.value=!checkTerms.value;
                    },
                  );
                },
                ),
                Text("تذكرني", style: AppTextStyle.font9BlackRegular),
                Spacer(),
                GestureDetector(
                  onTap: (){
                    context.pushNamed(emailScreen);
                  },
                  child: Text(
                    "نسيت كلمة المرور؟",
                    style: AppTextStyle.font9BlackRegular.copyWith(
                      color: AppColors.redColor,
                    ),
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
