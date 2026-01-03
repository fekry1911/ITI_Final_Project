import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../core/theme/color/colors.dart';
import '../../../core/theme/text_theme/text_theme.dart';
import '../../community/logic/get_all_posts_cubit.dart';
import '../../profile/logic/posts_cubit.dart';
import '../data/creatr_post_model.dart';
import '../logic/create_post_cubit.dart';

class AddPost extends StatelessWidget {
  const AddPost({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CreatePostCubit>();
    final allPostsCubit = context.read<GetAllPostsCubit>();
    final postsCubit = context.read<PostsCubit>();
    final Map<String, String> postTypeMap = {
      'DISCUSSION': 'نقاش',
      'CAR_BOOKING': 'حجز سيارة',
      'OPINION': 'رأي',
    };

    return BlocListener<CreatePostCubit, CreatePostState>(
      listener: (context, state) {
        if (state is CreatePostSuccess) {
          print(state.postModel);
          cubit.clearContent();

          print(
            "AddPost: Post success! Prepending to allPostsCubit. Post ID: ${state.postModel.id}",
          );
          // Update the feed using the captured cubit instance
          allPostsCubit.addNewPost(state.postModel);
          postsCubit.addNewPost(state.postModel);

          Navigator.pop(context);
        } else if (state is CreatePostError) {
          print("AddPost: Error: ${state.error}");
          CherryToast.error(
            title: Text(
              "خطأ",
              style: AppTextStyle.font18GreyRegular.copyWith(fontSize: 14.sp),
            ),
            description: Text(
              state.error,
              style: AppTextStyle.font18GreyRegular.copyWith(fontSize: 12.sp),
            ),
            animationType: AnimationType.fromRight,
            animationDuration: const Duration(milliseconds: 500),
            autoDismiss: true,
          ).show(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            BlocBuilder<CreatePostCubit, CreatePostState>(
              buildWhen: (prev, curr) => curr is CreatePostTypeChanged,
              builder: (context, state) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.scaffoldColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.mainColor.withOpacity(0.3),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: cubit.selectedType,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: AppColors.mainColor,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                      style: AppTextStyle.font18GreyRegular.copyWith(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                      items: postTypeMap.entries.map((entry) {
                        return DropdownMenuItem<String>(
                          value: entry.key,
                          child: Text(entry.value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          cubit.changePostType(value);
                        }
                      },
                    ),
                  ),
                );
              },
            ),

            BlocSelector<CreatePostCubit, CreatePostState, bool>(
              selector: (state) {
                if (state is CreatePostContentChanged) {
                  return state.canPost;
                }
                return cubit.postContent.text.trim().isNotEmpty ||
                    cubit.pickedImage != null;
              },
              builder: (context, canPost) {
                return BlocBuilder<CreatePostCubit, CreatePostState>(
                  builder: (context, state) {
                    final isLoading = state is CreatePostLoading;

                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: MaterialButton(
                        disabledColor: AppColors.greyColor,
                        onPressed: (canPost && !isLoading)
                            ? () {
                                final model = CreatePostModel(
                                  content: cubit.postContent.text,
                                  category: cubit.selectedType,
                                  media: cubit.pickedImage != null
                                      ? File(cubit.pickedImage!.path)
                                      : null,
                                );
                                cubit.createPost(model);
                              }
                            : null,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        color: AppColors.mainColor,
                        child: isLoading
                            ? SizedBox(
                                width: 20.r,
                                height: 20.r,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                "إنشاء",
                                style: AppTextStyle.font18GreyRegular.copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.whiteColor,
                                ),
                              ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cubit.postContent,
                        maxLines: null,
                        onChanged: cubit.onContentChanged,
                        style: AppTextStyle.font18GreyRegular.copyWith(
                          fontSize: 16.sp,
                          color: Colors.black87,
                        ),

                        decoration: InputDecoration(
                          fillColor: AppColors.scaffoldColor,
                          filled: true,
                          hintText: "ماذا يدور في بالك؟",
                          hintStyle: AppTextStyle.font18GreyRegular.copyWith(
                            fontSize: 16.sp,
                            color: Colors.grey,
                          ),

                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,

                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      BlocBuilder<CreatePostCubit, CreatePostState>(
                        builder: (context, state) {
                          if (cubit.pickedImage != null) {
                            return Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20.h),
                                  width: double.infinity,
                                  height: 250.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    image: DecorationImage(
                                      image: FileImage(
                                        File(cubit.pickedImage!.path),
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 5),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 25.h,
                                  right: 10.w,
                                  child: GestureDetector(
                                    onTap: cubit.removeImage,
                                    child: Container(
                                      padding: EdgeInsets.all(5.r),
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 18.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              ListTile(
                onTap: cubit.pickImage,
                leading: Icon(
                  LucideIcons.image,
                  color: AppColors.mainColor,
                  size: 24.r,
                ),
                title: Text(
                  "اضافة صورة",
                  style: AppTextStyle.font18GreyRegular.copyWith(
                    fontSize: 14.sp,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
