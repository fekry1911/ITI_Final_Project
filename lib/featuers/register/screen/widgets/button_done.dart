import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

import '../../logic/register_user_cubit.dart';

class ButtonDoneRegister extends StatelessWidget {
  const ButtonDoneRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
      builder: (context, state) {
        var cubit = context.read<RegisterUserCubit>();
        return SizedBox(
          width: 230.w,
          height: 40.h,

          child: MaterialButton(
            onPressed: () {
              if (cubit.formKey.currentState!.validate()) {
                cubit.signUp(
                  firstName: cubit.firstNameController.text,
                  lastName: cubit.lastNameController.text,
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
            child: state is RegisterUserLoading
                ? CircularProgressIndicator()
                : Text("ابدأ الآن", style: AppTextStyle.font18WhiteMedium),
          ),
        );
      },
    );
  }
}
