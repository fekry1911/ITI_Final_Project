import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_content.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_header.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_media.dart';
import '../../../../core/shared_widgets/modern_card.dart'; // Added Import
import '../../../../core/theme/color/colors.dart';
import '../../data/model/post_model.dart';
import 'Likes_comments.dart';

class PostItem extends StatelessWidget {
  final PostModel post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),  // Add margin for list look
      elevation: 0, // ModernCard handles shadow manually usually, but passing 0 here.
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
    );

  }
}
