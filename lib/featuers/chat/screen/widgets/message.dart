import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';

class WhatsAppMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  final bool isRead;
  final String time;

  const WhatsAppMessage({
    super.key,
    required this.message,
    required this.isMe,
    this.isRead = false,
    this.time = "12:00",
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isMe
        ? AppColors.mainColor.withOpacity(0.8)
        : AppColors.greyColor.withOpacity(0.6);
    final textColor =isMe?AppColors.whiteColor: AppColors.blackColor;


    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
        constraints: BoxConstraints(maxWidth: 250.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(isMe ? 16.r : 0),
            bottomRight: Radius.circular(isMe ? 0 : 16.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: AppTextStyle.font11BlackRegular.copyWith(
                color: textColor,
                fontSize: 10.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 8.sp,
                  ),
                ),
              /*  if (isMe) ...[
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.done_all,
                    size: 16.r,
                    color: isRead ? Colors.blue : Colors.white70,
                  ),
                ],*/
              ],
            ),
          ],
        ),
      ),
    );
  }
}