import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_content.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_header.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_media.dart';

import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/featuers/community/data/model/post_model.dart';
import 'Likes_comments.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: AppColors.primary.withOpacity(0.05)),
      ),
     // color: AppColors.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostHeader(post: post),
            SizedBox(height: 12.h),
            PostContent(content: post.content),
            if (post.media != null) ...[
              SizedBox(height: 12.h),
              PostMedia(mediaUrl: post.media),
            ],
            SizedBox(height: 12.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Divider(
                height: 1,
                thickness: 1,
                color: AppColors.primaryLight,
              ),
            ),
            LikesAndComments(post: post),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);

  }
}
