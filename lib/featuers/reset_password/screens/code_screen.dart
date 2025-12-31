import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/reset_password/screens/widgest/shared_button.dart';
import 'package:iti_moqaf/featuers/reset_password/screens/widgest/title_desc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/shared_widgets/toast.dart';
import '../../../core/theme/color/colors.dart';
import '../logic/reset_password_cubit.dart';

class CodeScreen extends StatelessWidget {
  final String email;

  CodeScreen({super.key, required this.email});

  ValueNotifier<bool> isComplete = ValueNotifier(false);
  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20.sp),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TitleAndDesc(
                title: 'تحقق من بريدك الإلكتروني',
                desc:[
                  "لقد أرسلنا رابط إعادة التعيين إلى ",
                  email,
                  " أدخل رمز مكون من 5 أرقام الموجود في البريد الإلكتروني "
                ]
              ),
              SizedBox(height: 30.h),
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
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    activeColor:AppColors.mainColor,
                    selectedColor: AppColors.mainColor,
                    inactiveColor: Colors.grey,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  onCompleted: (v) {
                    isComplete.value = v.isEmpty;
                    code = v;
                  },
                  onChanged: (value) {},
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
              ),
          
              SizedBox(height: 30.h),
              BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                builder: (context, state) {
                  var cubit = context.read<ResetPasswordCubit>();
                  return ValueListenableBuilder(
                    valueListenable: isComplete,
                    builder: (context, enabled, child) {
                      return SharedButton(
                        isLoading: state is ResetPasswordLoading,
                        onTap: enabled ? null : () {
                          cubit.verifyCode(code!);
                        },
                        text: "التحقق من الكود",
                      );
                    },
                  );
                },
              ),
              BlocListener<ResetPasswordCubit, ResetPasswordState>(listener: (
                  BuildContext context, state) {
                if (state is ResetPasswordSuccess){
                  sucssesToast(context, "ناجحه", "تم ارسال كود التحقق");
                  context.pushNamed(newPasswordScreen, arguments: state.data);
                }
                else if (state is ResetPasswordError){
                  errorToast(context, "خطأ", state.error);
                }
          
              }, child: SizedBox.shrink(),)
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,

    );
  }
}
