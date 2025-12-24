import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/models/comments_response_model.dart';
import 'package:iti_moqaf/core/shared_widgets/error_page.dart';
import 'package:lottie/lottie.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:iti_moqaf/featuers/community/logic/get_all_posts_cubit.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/di/di.dart';
import 'package:iti_moqaf/core/logic/comment_cubit/comments_cubit.dart';
import 'package:iti_moqaf/core/models/user_model.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';

void showFacebookCommentsSheet(
  BuildContext context,
  String postID,
  String name,
  GetAllPostsCubit getAllPostsCubit,
) {
  final draggableController = DraggableScrollableController();
  final commentController = TextEditingController();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return DraggableScrollableSheet(
        controller: draggableController,
        initialChildSize: 1,
        minChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return BlocProvider(
            create: (context) => getIt<CommentsCubit>()..getComments(postID),
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
                ),
                child: Column(
                  children: [
                    // Header Bar
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    // Comments List
                    Expanded(
                      child: BlocBuilder<CommentsCubit, CommentsState>(
                        builder: (context, state) {
                          var cubit = context.read<CommentsCubit>();
                          bool isLoading = state.status == CommentsStatus.loading;
                          final comments = isLoading ? fakeCommentsList : state.comments;

                          if (state.status == CommentsStatus.error) {
                            return Center(
                              child: NetWorkError(
                                onPressed: () => cubit.getComments(postID),
                              ),
                            );
                          }

                          if (state.status == CommentsStatus.success && comments.isEmpty) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "assets/animation/empty.json",
                                  width: double.infinity,
                                  height: 200.h,
                                ),
                                SizedBox(height: 10.h),
                                const Text("No comments yet"),
                              ],
                            );
                          }

                          return ListView.builder(
                            controller: scrollController,
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              return Skeletonizer(
                                enabled: isLoading,
                                child: ListTile(
                                  leading: GestureDetector(
                                    onTap: () {
                                      context.pushNamed(profileScreen, arguments: comments[index].user.id);
                                    },
                                    child: CircleAvatar(
                                      backgroundImage: NetworkImage(comments[index].user.avatarUrl),
                                    ),
                                  ),
                                  title: Text('${comments[index].user.firstName} ${comments[index].user.lastName}'),
                                  subtitle: Text(comments[index].content),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Divider(thickness: 1, color: Colors.grey[300]),
                    // Input Field
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10.w,
                        right: 10.w,
                        bottom: MediaQuery.of(context).viewInsets.bottom + 10.h,
                        top: 10.h,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: commentController,
                              onTap: () => draggableController.animateTo(
                                0.95,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                              decoration: InputDecoration(
                                hintText: "$name علق باسم ",
                                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: BorderSide(color: AppColors.mainColor, width: 2.w),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: BorderSide(color: AppColors.mainColor, width: 2.w),
                                ),
                                suffixIcon: BlocConsumer<CommentsCubit, CommentsState>(
                                  listener: (context, state) {
                                    if (state.status == CommentsStatus.addSuccess) {
                                      commentController.clear();
                                      getAllPostsCubit.updatePostLocal(
                                        postID,
                                        commentsCount: state.comments.length,
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return IconButton(
                                      onPressed: () {
                                        final content = commentController.text.trim();
                                        if (content.isNotEmpty) {
                                          context.read<CommentsCubit>().addComment(postID, content);
                                        }
                                      },
                                      icon: state.status == CommentsStatus.adding
                                          ? SizedBox(
                                              width: 15.r,
                                              height: 15.r,
                                              child: const CircularProgressIndicator(strokeWidth: 2),
                                            )
                                          : FaIcon(
                                              FontAwesomeIcons.share,
                                              color: AppColors.mainColor,
                                              size: 20.r,
                                            ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// Fake comments
List<CommentModel> fakeCommentsList = [
  CommentModel(
    id: '6949e8866c35e80b87930a4b',
    user: User(
      id: '6946a3c92f8ca5d72668b3e2',
      firstName: 'Ahmed',
      lastName: 'Hassan',
      avatar: 'avatar1.jpg',
    ),
    post: '6948a9a7c2e4f4f205306eea',
    content: 'Great post! Thanks for sharing.',
    createdAt: DateTime(2025, 12, 23, 0, 55, 34),
    updatedAt: DateTime(2025, 12, 23, 0, 55, 34),
    version: 0,
  ),
  CommentModel(
    id: '6949e8866c35e80b87930a4c',
    user: User(
      id: '6946a3c92f8ca5d72668b3e3',
      firstName: 'Sara',
      lastName: 'Mohamed',
      avatar: 'avatar2.jpg',
    ),
    post: '6948a9a7c2e4f4f205306eea',
    content: 'I totally agree with you! 👍',
    createdAt: DateTime(2025, 12, 23, 1, 10, 20),
    updatedAt: DateTime(2025, 12, 23, 1, 10, 20),
    version: 0,
  ),
  CommentModel(
    id: '6949e8866c35e80b87930a4d',
    user: User(
      id: '6946a3c92f8ca5d72668b3e4',
      firstName: 'Khaled',
      lastName: 'Ali',
      avatar: 'avatar3.jpg',
    ),
    post: '6948a9a7c2e4f4f205306eea',
    content: 'This is very helpful, thank you!',
    createdAt: DateTime(2025, 12, 23, 1, 25, 45),
    updatedAt: DateTime(2025, 12, 23, 1, 25, 45),
    version: 0,
  ),
  CommentModel(
    id: '6949e8866c35e80b87930a4e',
    user: User(
      id: '6946a3c92f8ca5d72668b3e5',
      firstName: 'Nour',
      lastName: 'Ibrahim',
      avatar: 'avatar4.jpg',
    ),
    post: '6948a9a7c2e4f4f205306eea',
    content: 'Can you explain more about this topic?',
    createdAt: DateTime(2025, 12, 23, 2, 5, 12),
    updatedAt: DateTime(2025, 12, 23, 2, 5, 12),
    version: 0,
  ),
  CommentModel(
    id: '6949e8866c35e80b87930a4f',
    user: User(
      id: '6946a3c92f8ca5d72668b3e6',
      firstName: 'Omar',
      lastName: 'Mahmoud',
      avatar: 'avatar5.jpg',
    ),
    post: '6948a9a7c2e4f4f205306eea',
    content: 'Interesting perspective!',
    createdAt: DateTime(2025, 12, 23, 2, 30, 50),
    updatedAt: DateTime(2025, 12, 23, 2, 30, 50),
    version: 0,
  ),
  CommentModel(
    id: '6949e8866c35e80b87930a50',
    user: User(
      id: '6946a3c92f8ca5d72668b3e7',
      firstName: 'Mona',
      lastName: 'Salem',
      avatar: 'avatar6.jpg',
    ),
    post: '6948a9a7c2e4f4f205306eea',
    content: 'I have a different opinion on this matter.',
    createdAt: DateTime(2025, 12, 23, 3, 15, 30),
    updatedAt: DateTime(2025, 12, 23, 3, 15, 30),
    version: 0,
  ),
];
