import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/shared_widgets/toast.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/button_done.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/email_password.dart';
import '../../../core/const/const_paths.dart';
import '../../../core/shared_widgets/image_messsage.dart';
import '../../../core/theme/color/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ImageAndMessage(
                title: 'مرحبا بعودتك',
                desc: 'قم بتسجيل الدخول للوصول لحسابك',
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    EmailAndPassword(),
                    SizedBox(height: 24.h),
                    ButtonDone(),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ليس لديك حساب؟",
                          style: AppTextStyle.font11BlackRegular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(registerScreen);
                          },
                          child: Text(
                            "سجّل الآن",
                            style: AppTextStyle.font11RedMedium.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h,),
                  ],
                ),
              ),

              BlocListener<LoginCubit, LoginStates>(
                listener: (BuildContext context, state) {
                  if (state is LoginSuccess) {
                    sucssesToast(
                      context,
                      " عمليه تسجيل دخول ناجحه",
                      "مرحبا بك",
                    );
                    context.pushAndRemoveUntil(homeScreen);
                  }
                  if (state is LoginError) {
                    errorToast(context, " عمليه تسجيل دخول فاشله", state.error);
                  }
                },
                child: SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
