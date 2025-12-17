import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/shared_widgets/shared_text_form_field.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

import '../../logic/register_user_cubit.dart';

class EmailAndPasswordRegister extends StatefulWidget {
  EmailAndPasswordRegister({super.key});

  @override
  State<EmailAndPasswordRegister> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPasswordRegister> {
  bool erm = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterUserCubit, RegisterUserState>(
      builder: (context, state) {
        var cubit = context.read<RegisterUserCubit>();
        return Form(
          key: cubit.formKey,
          child: Column(
            children: [
              SharedTextFormField(
                controller: cubit.firstNameController,
                hintText: " الاسم الاول",
                validator: (string) {
                  if(string!.isEmpty){
                    return "FirstName Require";
                  }
                  return null;
                },
                suffixIcon: Icon(Icons.account_circle),
              ),
              SizedBox(height: 10.h),
              SharedTextFormField(
                controller: cubit.lastNameController,
                hintText: "الاسم الثاني",
                validator: (string) {
                  if(string!.isEmpty){
                    return "LastName Require";
                  }
                  return null;
                },
                suffixIcon: Icon(Icons.phone_android),
              ),
              SizedBox(height: 10.h),

              SharedTextFormField(
                controller: cubit.emailController,
                hintText: "البريد الالكتروني",
                validator: (string) {
                  if(string!.isEmpty){
                    return "Email Require";
                  }
                  return null;
                },
                suffixIcon: Icon(Icons.email),
              ),

              SizedBox(height: 10.h),
              SharedTextFormField(
                controller: cubit.passwordController,
                hintText: "كلمه المرور",
                validator: (string) {
                  if(string!.isEmpty){
                    return "Password Require";
                  }
                  return null;
                },
                suffixIcon: Icon(Icons.visibility_off),
              ),
              SizedBox(height: 7.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: erm,
                    onChanged: (s) {
                      setState(() {
                        erm = s!;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      "عند تحديد هذا المربع، فإنك تقرّ بموافقتك على الشروط والأحكام.",
                      style: AppTextStyle.font9BlackRegular.copyWith(
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
