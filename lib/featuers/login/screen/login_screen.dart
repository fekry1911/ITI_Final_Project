import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/shared_widgets/toast.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/button_done.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/email_password.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/social_media_auth.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/shared_widgets/container_stack.dart';
import '../../../core/shared_widgets/image_messsage.dart';

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
              SizedBox(height: 30.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                child: Column(
                  children: [
                    EmailAndPassword(),
                    SizedBox(height: 15.h),
                    SocialMediaAuth(),
                    SizedBox(height: 15.h),
                    ButtonDone(),
                    SizedBox(height: 15.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "ليس لديك حساب؟",
                          style: AppTextStyle.font11BlackRegular,
                        ),
                        SizedBox(width: 3.w),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(registerScreen);
                          },
                          child: Text(
                            "سجّل الآن",
                            style: AppTextStyle.font11RedMedium,
                          ),
                        ),
                      ],
                    ),
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
