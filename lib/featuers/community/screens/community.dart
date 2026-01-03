import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/helpers/cach_helper.dart';
import '../../../core/shared_widgets/error_page.dart';
import '../../../core/shared_widgets/login_first.dart';
import '../../../core/theme/color/colors.dart';
import '../../../core/theme/text_theme/text_theme.dart';
import '../../profile/logic/posts_cubit.dart';
import '../../profile/logic/profile_cubit.dart';
import '../data/model/fake_data/model.dart';
import '../logic/get_all_posts_cubit.dart';

class Community extends StatelessWidget {
  Community({super.key});

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getString(key: "token");
    if (token == null) {
      return LoginFirst();
    } else {
      return NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - 200) {
            if (context.read<GetAllPostsCubit>().lastPage !=
                context.read<GetAllPostsCubit>().page) {
              context.read<GetAllPostsCubit>().getAllPosts();
            }
          }
          return false;
        },
        child: Center(
          child: RefreshIndicator(
            onRefresh: () {
              context.read<GetAllPostsCubit>().getAllPosts();
              context.read<PostsCubit>().getAllPostsOfUser(
                CacheHelper.getString(key: "userId"),
              );
              return Future.delayed(Duration(seconds: 1));
            },
            child: ListView(
              children: [
                SizedBox(height: 8.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Skeletonizer(
                            enabled: state is ProfileLoading,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.r),
                              child: Image.network(
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.person),
                                state is ProfileLoaded
                                    ? state.user!.avatarUrl
                                    : "https://media.licdn.com/media/AAYQAQSOAAgAAQAAAAAAAB-zrMZEDXI2T62PSuT6kpB6qg.png",
                                width: 35.h,
                                height: 35.h,
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  addPost,
                                  arguments: {
                                    "allPosts": context
                                        .read<GetAllPostsCubit>(),
                                    "profilePosts": context.read<PostsCubit>(),
                                  },
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.r,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight.withOpacity(
                                    0.5,
                                  ),
                                  borderRadius: BorderRadius.circular(24.r),
                                  border: Border.all(
                                    color: AppColors.primary.withOpacity(0.1),
                                  ),
                                ),
                                child: Text(
                                  "ماذا يدور في بالك؟",
                                  style: AppTextStyle.font14GreyRegular
                                      .copyWith(color: AppColors.textSecondary),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          IconButton(
                            onPressed: () {},
                            icon: FaIcon(
                              FontAwesomeIcons.solidImage,
                              color: AppColors.primary,
                              size: 20.r,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  child: BlocBuilder<GetAllPostsCubit, GetAllPostsState>(
                    builder: (context, state) {
                      var cubit = context.read<GetAllPostsCubit>();

                      final isLoading = state is GetAllPostsLoading;

                      print(
                        "Community Builder: State=${state.runtimeType}, cubitHash=${identityHashCode(context.read<GetAllPostsCubit>())}",
                      );
                      final posts = isLoading
                          ? List.generate(3, (_) => FakePost.fake())
                          : state is GetAllPostsSuccess
                          ? state.postModel
                          : [];
                      print(
                        "Community Builder: cubitHashCode=${identityHashCode(context.read<GetAllPostsCubit>())}, postsCount=${posts.length}",
                      );
                      if (state is GetAllPostsError&& state.message != "لا يوجد اتصال بالإنترنت") {
                        return NetWorkError(
                          error: state.message,
                          onPressed: () {
                            cubit.getAllPosts();
                          },
                        );
                      }

                      return ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          if (index == posts.length) {
                             return Padding(
                               padding: EdgeInsets.all(16.h),
                               child: const Center(child: CircularProgressIndicator()),
                             );
                          }
                          return Skeletonizer(
                            enabled: isLoading,
                            child: PostItem(post: posts[index]),
                          );
                        },
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: posts.length + (state is GetAllPostsSuccess && state.isLoadingMore ? 1 : 0),
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox.shrink();
                          // return Divider(color: Colors.grey[300]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
