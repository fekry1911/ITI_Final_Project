import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/button_done.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/email_password.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/image_messsage.dart';
import 'package:iti_moqaf/featuers/login/screen/widgets/social_media_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // ✅ default true

      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 30.h),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImageAndMessage(),
                SizedBox(height: 20.h),
                EmailAndPassword(),
                SizedBox(height: 20.h),
                SocialMediaAuth(),
                SizedBox(height: 20.h),
                ButtonDone(),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "ليس لديك حساب؟",
                      style: AppTextStyle.font11BlackRegular,
                    ),
                    SizedBox(width: 3),
                    Text("سجّل الآن", style: AppTextStyle.font11RedMedium),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
