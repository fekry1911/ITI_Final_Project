import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';

class UserCard extends StatelessWidget {
  UserCard({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.avatar,
    required this.time,
    required this.imageUrl,
    required this.isMe,
    required this.updatedAt,
    required this.id,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String avatar;
   final String time;
  final String imageUrl;
  final bool isMe;
  final DateTime updatedAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;


    return Card(
      color: AppColors.scaffoldColor,
      borderOnForeground: false,
      elevation: 0,

      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.w, horizontal: 8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 23.r, backgroundImage: NetworkImage(avatar)),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${firstName} ${lastName}",
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 13.sp,
                          color: isDark
                              ? AppColors.mainColor
                              : AppColors.blackColor,
                        ),
                      ),
                      Text(
                        time,
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontSize: 10.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          "message",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.font14GreyRegular.copyWith(
                            fontSize: 10.sp,
                          ),
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
    );
  }
}
