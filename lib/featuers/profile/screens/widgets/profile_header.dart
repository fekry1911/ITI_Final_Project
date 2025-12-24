import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/models/user_model.dart';

import '../../../../core/theme/text_theme/text_theme.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;
   ProfileHeader({super.key, this.user,required this.id});
  String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundImage:
                  user?.avatarUrl != null && user!.avatarUrl.isNotEmpty
                  ? NetworkImage(user!.avatarUrl)
                  : const AssetImage('assets/avatar.png') as ImageProvider,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.primary,
                child: Icon(Icons.camera_alt, size: 14, color: Colors.white),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          "${user?.firstName ?? ''} ${user?.lastName ?? ''}".trim().isEmpty
              ? "المستخدم"
              : "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          user?.email ?? "",
          style: const TextStyle(color: AppColors.subtitle),
        ),
        const SizedBox(height: 8),
       if(id != CacheHelper.getString(key: "userId"))
         Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30.r)),
              boxShadow:[
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 10,

                )
              ],
            ),
            width: 100.w,
            height: 30.h,
            child: MaterialButton(
              onPressed:(){},
              color: AppColors.whiteColor,
              splashColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Text("مراسله", style: AppTextStyle.font13BlackSemiMedium),
            ),
          ),
        ),

      ],
    );
  }
}
