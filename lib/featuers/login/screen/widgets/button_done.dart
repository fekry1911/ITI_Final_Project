import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/login/logic/login_cubit.dart';

class ButtonDone extends StatelessWidget {
  const ButtonDone({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      builder: (context, state) {
        var cubit = context.read<LoginCubit>();
        return SizedBox(
          width: 230.w,
          height: 40.h,

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
            color: AppColors.blackColor,
            splashColor: AppColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: state is LoginLoading
                ? CircularProgressIndicator()
                : Text("تأكيد", style: AppTextStyle.font18WhiteMedium),
          ),
        );
      },
    );
  }
}
