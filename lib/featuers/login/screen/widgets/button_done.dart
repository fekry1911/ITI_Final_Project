import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../logic/login_cubit.dart';

class ButtonDone extends StatelessWidget {
  const ButtonDone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return Container(
          width: double.infinity,
          height: 54.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primaryDark],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.35),
                blurRadius: 15,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: MaterialButton(
            onPressed: state is LoginLoading
                ? null
                : () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.login(
                        email: cubit.emailController.text,
                        password: cubit.passwordController.text,
                      );
                    }
                  },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: state is LoginLoading
                ? SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    "تسجيل الدخول",
                    style: AppTextStyle.font18WhiteBold,
                  ),
          ),
        );

      },
    );
  }
}
