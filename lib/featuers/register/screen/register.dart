import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/register/screen/widgets/button_done.dart';
import 'package:iti_moqaf/featuers/register/screen/widgets/email_password.dart';
import '../../../core/const/const_paths.dart';
import '../../../core/shared_widgets/image_messsage.dart';
import '../../../core/shared_widgets/toast.dart';
import '../../../core/theme/text_theme/text_theme.dart';
import '../logic/register_user_cubit.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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
                title: ' ابدا الان',
                desc: 'من خلال انشاء حساب مجاني',
                register: true,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0.w,
                  vertical: 10.h,
                ),
                child: Column(
                  children: [
                    EmailAndPasswordRegister(),
                    SizedBox(height: 20.h),
                    ButtonDoneRegister(),
                    SizedBox(height: 20.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "انت عضو بالفعل!",
                          style: AppTextStyle.font11BlackRegular,
                        ),
                        SizedBox(width: 3),
                        GestureDetector(
                          onTap: () {
                            context.pushNamed(loginScreen);
                          },
                          child: Text(
                            "سجّل دخول",
                            style: AppTextStyle.font11RedMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              BlocListener<RegisterUserCubit, RegisterUserState>(
                listener: (BuildContext context, state) {
                  if (state is RegisterUserSuccess) {
                    sucssesToast(
                      context,
                      "برجاء تاكيد حسابك ",
                      "تم ارسال رسالة الي حسابك بنجاح",
                    );
                    context.pushNamed(
                      verifyEmailScreen,
                      arguments: state.user.email,
                    );
                  }
                  if (state is RegisterUserError) {
                    errorToast(context, " عمليه تسجيل فاشله", state.error);
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
