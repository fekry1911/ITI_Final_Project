import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/shared_widgets/error_page.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/featuers/community/data/model/fake_data/model.dart';
import 'package:iti_moqaf/featuers/community/logic/get_all_posts_cubit.dart';
import 'package:iti_moqaf/featuers/community/screens/widgets/post_card.dart';
import 'package:iti_moqaf/featuers/profile/logic/posts_cubit.dart';
import 'package:iti_moqaf/featuers/profile/logic/profile_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Community extends StatefulWidget {
  const Community({super.key});

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    var token = CacheHelper.getString(key: "token");
    if (token == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("انت غير مسجل يجب التسجيل اولا"),
            TextButton(
              onPressed: () {
                context.pushNamed(loginScreen);
              },
              child: Text("تسجيل الدخول"),
            ),
          ],
        ),
      );
    } else {
      return Center(
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 40),
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return Row(
                      children: [
                        Skeletonizer(
                          enabled: state is ProfileLoading,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.r),
                            child: Image.network(
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
                                  "allPosts": context.read<GetAllPostsCubit>(),
                                  "profilePosts": context.read<PostsCubit>(),
                                },
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.r,
                                vertical: 3.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: BoxBorder.all(
                                  color: AppColors.greyText,
                                ),
                                borderRadius: BorderRadius.circular(30.r),
                              ),
                              child: Text("ماذا يدور ف بالك؟"),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.images,
                            color: AppColors.greyText,
                            size: 18.r,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.h),
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
                    if (state is GetAllPostsError) {
                      return NetWorkError(
                        onPressed: () {
                          cubit.getAllPosts();
                        },
                      );
                    }

                    return ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        return Skeletonizer(
                          enabled: isLoading,
                          child: PostItem(post: posts[index]),
                        );
                      },
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: posts.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(thickness: 1, color: AppColors.greyText);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
