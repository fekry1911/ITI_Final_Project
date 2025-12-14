import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/register/screen/widgets/button_done.dart';
import 'package:iti_moqaf/featuers/register/screen/widgets/email_password.dart';
import 'package:iti_moqaf/featuers/register/screen/widgets/image_messsage.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/theme/color/colors.dart';
import '../../../core/theme/text_theme/text_theme.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Center(
          child: Stack(
            children: [
              Container(
                height: .43.sh,
                width: 1.sw,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50.r),
                    bottomRight: Radius.circular(50.r),
                  ),
                ),
              ),
              Positioned(
                top: 25.h,
                child: IconButton(
                  onPressed: () {
                    print("Done");
                   context.popScreen();
                  },
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ImageAndMessageRegister(),
                    SizedBox(height: 30.h),
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
            ],
          ),
        ),
      ),
    );
  }
}
