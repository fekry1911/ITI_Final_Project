import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import '../../../../core/const/const_paths.dart';
import '../../../../core/helpers/cach_helper.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../logic/profile_cubit.dart';

class ProfileHeader extends StatelessWidget {
  final User? user;

  ProfileHeader({super.key, this.user, required this.id});

  String id;

  @override
  Widget build(BuildContext context) {
    bool isMyProfile = id == CacheHelper.getString(key: "userId");
    double avatarRadius = 60.r;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Card Content
        Container(
          margin: EdgeInsets.only(top: avatarRadius),
          padding: EdgeInsets.only(
            top: avatarRadius + 10.h,
            bottom: 20.h,
            left: 16.w,
            right: 16.w,
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.scaffoldColor,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                "${user?.firstName ?? ''} ${user?.lastName ?? ''}".trim().isEmpty
                    ? "المستخدم"
                    : "${user?.firstName ?? ''} ${user?.lastName ?? ''}",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ).animate().fadeIn(delay: 200.ms).moveY(
                    begin: 10,
                    end: 0,
                    duration: 400.ms,
                  ),
              const SizedBox(height: 4),
              Text(
                user?.email ?? "",
                style: const TextStyle(color: AppColors.subtitle, fontSize: 14),
              ).animate().fadeIn(delay: 300.ms).moveY(
                    begin: 10,
                    end: 0,
                    duration: 400.ms,
                  ),
              if (!isMyProfile) ...[
                SizedBox(height: 20.h),
                ElevatedButton.icon(
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: AppColors.primary.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  ),
                  icon: Icon(Icons.chat_bubble_outline, size: 20),
                  label: Text("مراسلة", style: TextStyle(fontSize: 16.sp)),
                ).animate().fadeIn(delay: 500.ms).scale(),
              ],
            ],
          ),
        ),
        // Avatar
        Positioned(
          top: 0,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.scaffoldColor, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.network(
                      user?.avatarUrl ?? "",
                      width: avatarRadius * 2,
                      height: avatarRadius * 2,
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
                        return Icon(
                          Icons.person,
                          size: avatarRadius,
                          color: Colors.grey,
                        );
                      },
                    ),
                  ),
                ),
              ).animate().scale(duration: 500.ms, curve: Curves.easeOutBack),
              if (isMyProfile)
                InkWell(
                  onTap: () {
                    context.read<ProfileCubit>().pickImage();
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.4),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child:
                        Icon(Icons.camera_alt, size: 20, color: Colors.white),
                  ),
                ).animate().fadeIn(delay: 400.ms).scale(),
            ],
          ),
        ),
      ],
    );
  }
}
