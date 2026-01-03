import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import '../../../../core/const/const_paths.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/theme/text_theme/text_theme.dart';
import '../../data/model/post_model.dart';
import '../../logic/get_all_posts_cubit.dart';
import '../../logic/like_post_cubit.dart';

class PostHeader extends StatelessWidget {
  final PostModel post;

  const PostHeader({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.pushNamed(
                profileScreen,
                arguments: {
                  "id": post.user.id,
                  "getAllPostsCubit": context
                      .read<GetAllPostsCubit>(),
                  "likePost": context
                      .read<LikePostCubit>(),
                },
              );
            },
            child: CircleAvatar(
              radius: 23.r,
              backgroundColor: AppColors.mainColor,
              child: CircleAvatar(
                radius: 22.r,
                backgroundColor: AppColors.whiteColor,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: Image.network(
                    fit: BoxFit.cover,
                    post.user.avatarUrl,
                    width: 60.h,
                    height: 60.h,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.person),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${post.user.firstName} ${post.user.lastName}",
                  style: AppTextStyle.font13BlackSemiMedium,
                ),
                Text(
                  post.category,
                  style: AppTextStyle.font13MainColorMedium.copyWith(
                    color: AppColors.greyColor,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatTimeAgo(post.createdAt),
            style: AppTextStyle.font13MainColorMedium.copyWith(
              color: AppColors.greyColor.withOpacity(0.6),
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 7) return "${dateTime.day}/${dateTime.month}";
    if (difference.inDays >= 1) return "${difference.inDays}d";
    if (difference.inHours >= 1) return "${difference.inHours}h";
    if (difference.inMinutes >= 1) return "${difference.inMinutes}m";
    return "now";
  }
}
