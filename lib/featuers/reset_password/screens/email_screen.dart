import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/reset_password/screens/widgest/shared_button.dart';
import 'package:iti_moqaf/featuers/reset_password/screens/widgest/title_desc.dart';
import '../../../core/const/const_paths.dart';
import '../../../core/shared_widgets/shared_text_form_field.dart';
import '../../../core/shared_widgets/toast.dart';
import '../logic/reset_password_cubit.dart';

class EnterEmail extends StatelessWidget {
  EnterEmail({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final ValueNotifier<bool> isButtonEnabled = ValueNotifier(false);

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleAndDesc(
                    title: 'نسيت كلمة المرور',
                    desc: ['من فضلك أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور'],
                  ),
                  SizedBox(height: 30.h),
                  Text("حسابك"),
                  SizedBox(height: 8.h),
                  Form(
                    key: formKey,
                    child: SharedTextFormField(
                      controller: emailController,
                      hintText: "ادخل حسابك",
                      onChanged: (value) {
                        isButtonEnabled.value = value.isNotEmpty;
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'الايميل مطلوب';
                        }
                        if (!value.contains('@')) {
                          return 'صيغة الايميل خاطئة';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 30.h),
                  ValueListenableBuilder<bool>(
                    valueListenable: isButtonEnabled,
                    builder: (context, enabled, child) {
                      return SharedButton(
                        isLoading: state is ResetPasswordLoading,
                        onTap: enabled
                            ? () {
                          if (formKey.currentState!.validate()) {
                            cubit.sendCode(emailController.text);
                          }
                        }
                            : null,
                        text: "إعادة تعيين كلمة المرور",
                      );
                    },
                  ),
                  BlocListener<ResetPasswordCubit, ResetPasswordState>(listener: (
                      BuildContext context, state) {
                    if (state is ResetPasswordSuccess){
                      sucssesToast(context, "ناجحه", "تم ارسال كود التحقق");
                      context.pushNamed(codeScreen, arguments: emailController.text);
                    }
                    else if (state is ResetPasswordError){
                      errorToast(context, "خطأ", state.error);
                    }
              
                  }, child: SizedBox.shrink(),)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
