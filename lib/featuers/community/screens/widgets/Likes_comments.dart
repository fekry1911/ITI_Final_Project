import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import 'package:iti_moqaf/core/shared_widgets/comments.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/community/data/model/post_model.dart';
import 'package:iti_moqaf/featuers/community/logic/get_all_posts_cubit.dart';
import 'package:iti_moqaf/featuers/community/logic/like_post_cubit.dart';

class LikesAndComments extends StatelessWidget {
  const LikesAndComments({super.key, required this.post});

  final PostModel post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      child: BlocBuilder<LikePostCubit, LikePostState>(
        buildWhen: (prev, curr) {
          if (curr is LikePostLoading) return curr.postId == post.id;
          if (curr is LikePostSuccess) return curr.postId == post.id;
          return false;
        },
        builder: (context, state) {
          bool isLiked = post.isLiked;
          int likes = post.likesCount;

          if (state is LikePostLoading && state.postId == post.id) {
            isLiked = state.isLiked;
            likes = state.likesCount;
          }

          if (state is LikePostSuccess && state.postId == post.id) {
            isLiked = state.isLiked;
            likes = state.likesCount;
            // Sync with main list
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<GetAllPostsCubit>().updatePostLocal(
                post.id,
                likesCount: likes,
                isLiked: isLiked,
              );
            });
          }

          return Row(
            children: [
              _ActionButton(
                icon: isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: isLiked ? AppColors.redColor : AppColors.greyText,
                label: "$likes",
                onTap: () {
                  context.read<LikePostCubit>().likePost(
                    postId: post.id,
                    currentIsLiked: isLiked,
                    currentLikes: likes,
                  );
                },
                animateIcon: isLiked,
              ),
              SizedBox(width: 20.w),
              BlocBuilder<GetAllPostsCubit, GetAllPostsState>(
                buildWhen: (prev, curr) {
                  if (curr is GetAllPostsSuccess && prev is GetAllPostsSuccess) {
                    final prevPost = prev.postModel.firstWhere(
                      (p) => p.id == post.id,
                      orElse: () => post,
                    );
                    final currPost = curr.postModel.firstWhere(
                      (p) => p.id == post.id,
                      orElse: () => post,
                    );
                    return prevPost.commentsCount != currPost.commentsCount;
                  }
                  return curr is GetAllPostsSuccess;
                },
                builder: (context, state) {
                  int comments = post.commentsCount;
                  if (state is GetAllPostsSuccess) {
                    final foundPost = state.postModel.firstWhere(
                      (p) => p.id == post.id,
                      orElse: () => post,
                    );
                    comments = foundPost.commentsCount;
                  }

                  return _ActionButton(
                    icon: FontAwesomeIcons.solidComment,
                    color: AppColors.greyText,
                    label: "$comments",
                    onTap: () {
                      showFacebookCommentsSheet(
                        context,
                        post.id,
                        "${post.user.firstName} ${post.user.lastName}",
                        context.read<GetAllPostsCubit>(),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;
  final VoidCallback onTap;
  final bool animateIcon;

  const _ActionButton({
    required this.icon,
    required this.color,
    required this.label,
    required this.onTap,
    this.animateIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Row(
          children: [
            FaIcon(icon, color: color, size: 18.r)
                .animate(target: animateIcon ? 1 : 0)
                .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 200.ms)
                .then()
                .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1), duration: 200.ms),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyle.font13BlackSemiMedium.copyWith(
                color: AppColors.greyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

