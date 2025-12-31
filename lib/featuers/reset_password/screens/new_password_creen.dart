import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/reset_password/screens/widgest/shared_button.dart';
import 'package:iti_moqaf/featuers/reset_password/screens/widgest/title_desc.dart';

import '../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../core/shared_widgets/toast.dart';
import '../logic/reset_password_cubit.dart';

class NewPasswordScreen extends StatelessWidget {
  NewPasswordScreen({super.key, this.token = ""});

  final String token;
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> showPassword = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          builder: (context, state) {
            var cubit = context.read<ResetPasswordCubit>();
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleAndDesc(
                    title: 'اضبط كلمة مرور جديدة',
                    desc: [
                      'أنشئ كلمة مرور جديدة، وتأكد أنها مختلفة عن الكلمات السابقة لأجل الأمان',
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text("حسابك"),
                  SizedBox(height: 8.h),
                  Form(
                    key: formKey,
                    child: ValueListenableBuilder(
                      valueListenable: showPassword,
                      builder:
                          (BuildContext context, bool value, Widget? child) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "كلمه المرور",
                                  style: AppTextStyle.font18BlackColorSemiBold,
                                ),
                                SizedBox(height: 8.h),
                                SharedTextFormField(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      showPassword.value = !showPassword.value;
                                    },
                                    icon: Icon(
                                      showPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  obscureText: showPassword.value,
                                  controller: password,
                                  hintText: "كلمه المرور",

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'كلمه المرور مطلوبه';
                                    }

                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  "تأكيد كلمه المرور",
                                  style: AppTextStyle.font18BlackColorSemiBold,
                                ),
                                SizedBox(height: 8.h),
                                SharedTextFormField(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      showPassword.value = !showPassword.value;
                                    },
                                    icon: Icon(
                                      showPassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                  ),
                                  obscureText: showPassword.value,
                                  controller: confirmPassword,
                                  hintText: "تأكيد كلمه المرور",

                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return ' كلمه المرور المؤكده مطلوبه';
                                    }

                                    return null;
                                  },
                                ),
                              ],
                            );
                          },
                    ),
                  ),
                  SizedBox(height: 30.h),
                  SharedButton(
                    isLoading: state is ResetPasswordLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        cubit.resetPassword(
                          password.text,
                          confirmPassword.text,
                          token,
                        );
                      }
                    },
                    text: "إعادة تعيين كلمة المرور",
                  ),
                  BlocListener<ResetPasswordCubit, ResetPasswordState>(
                    listener: (BuildContext context, state) {
                      if (state is ResetPasswordSuccess) {
                        sucssesToast(
                          context,
                          "ناجحه",
                          "تم اعاده تعيين كلمه المرور بنجاح",
                        );
                        context.pushNamed(loginScreen);
                      } else if (state is ResetPasswordError) {
                        errorToast(context, "خطأ", state.error);
                      }
                    },
                    child: SizedBox.shrink(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
