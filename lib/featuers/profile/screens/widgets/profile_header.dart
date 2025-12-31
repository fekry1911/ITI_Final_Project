import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/models/user_model.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';

import '../../../../core/const/const_paths.dart';
import '../../../../core/theme/text_theme/text_theme.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  ProfileHeader({super.key, this.user, required this.id});

  String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: Image.network(
                  user!.avatarUrl,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, size: 48, color: Colors.grey);
                  },
                ),
              ),
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
        SizedBox(height: 8),
        if (id != CacheHelper.getString(key: "userId"))
          Center(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.r)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              width: 100.w,
              height: 30.h,
              child: MaterialButton(
                onPressed: () {
                  context.pushNamed(
                    chatScreen,
                    arguments: {
                      "userId": CacheHelper.getString(key: "userId"),
                      "chatPartnerId": id,
                      "chatPartnerName":
                          "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                      "chatPartnerAvatar": user?.avatarUrl ?? '',
                    },
                  );
                },
                color: AppColors.whiteColor,
                splashColor: AppColors.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  "مراسله",
                  style: AppTextStyle.font13BlackSemiMedium,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
