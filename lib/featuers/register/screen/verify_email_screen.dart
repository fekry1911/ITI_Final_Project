import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/shared_widgets/toast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/theme/text_theme/text_theme.dart';
import '../logic/register_user_cubit.dart';

class VerifyEmailScreen extends StatelessWidget {
  final String email;

  const VerifyEmailScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h),
              Text(
                "تأكيد البريد الإلكتروني",
                style: AppTextStyle.font24BlackBold,
              ),
              SizedBox(height: 10.h),
              Text(
                "تم إرسال رمز التحقق إلى بريدك الإلكتروني",
                style: AppTextStyle.font14GreyRegular,
              ),
              Text(email, style: AppTextStyle.font14BlackMedium),
              SizedBox(height: 50.h),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    activeColor: Colors.blue,
                    selectedColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    context.read<RegisterUserCubit>().verifyEmail(
                      email: email,
                      code: v,
                    );
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
              SizedBox(height: 30.h),
              BlocConsumer<RegisterUserCubit, RegisterUserState>(
                listener: (context, state) {
                  if (state is VerifyEmailSuccess) {
                    sucssesToast(
                      context,
                      "نجاح",
                      "تم تأكيد البريد الإلكتروني بنجاح",
                    );
                    context.pushNamed(homeScreen);
                  } else if (state is VerifyEmailError) {
                    errorToast(context, "خطأ", state.error);
                  }
                },
                builder: (context, state) {
                  if (state is VerifyEmailLoading) {
                    return CircularProgressIndicator();
                  }
                  return SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
