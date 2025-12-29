import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/models/user_model.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/featuers/profile/logic/posts_cubit.dart';
import 'package:iti_moqaf/featuers/profile/logic/profile_cubit.dart';
import 'package:iti_moqaf/featuers/profile/screens/widgets/profile_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/shared_widgets/error_page.dart';
import '../../../core/shared_widgets/toast.dart';
import '../../community/data/model/fake_data/model.dart';
import '../../community/screens/widgets/post_card.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.id});

  String id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController = ScrollController();

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
      return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: CacheHelper.getString(key: "userId") != widget.id
              ? null
              : IconButton(
            onPressed: () {
              context.read<ProfileCubit>().logout();
            },
            icon: FaIcon(FontAwesomeIcons.signOut, color: AppColors.redColor),
          ),
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 200) {
              if (context
                  .read<PostsCubit>()
                  .lastPage !=
                  context
                      .read<PostsCubit>()
                      .page) {
                context.read<PostsCubit>().getAllPostsOfUser(widget.id);
              }
            }
            return false;
          },
          child: BlocListener<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is ProfileLoggedOut) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  loginScreen,
                      (route) => false,
                );
                CacheHelper.clearUser();
                CacheHelper.removeString(key: 'token');
                CacheHelper.removeString(key: 'userId');
                CacheHelper.removeString(key: 'uid');
                sucssesToast(
                  context,
                  "تم تسجيل الخروج بنجاح",
                  "نراك قريبا دمتم سالمين",
                );
                Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is ProfileError) {
                context.popScreen();
                errorToast(context, "مشكله ف تسجيل الخروج", state.message);
              }
            },
            child: Scaffold(
              backgroundColor: AppColors.background,
              body: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  final user = state is ProfileLoaded ? state.user : null;
                  return SingleChildScrollView(
                    controller: scrollController,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          width: 1.sw,
                          height: .5.sh,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primary,
                                AppColors.mainColor,
                                AppColors.background,
                                AppColors.mainColor,
                                AppColors.primary,
                              ],
                            ),
                          ),
                        ),

                        Container(
                          padding: EdgeInsets.only(
                            top: widget.id != CacheHelper.getString(key: "userId") ? 65.h:
                            30.h,
                          ),
                          margin: EdgeInsets.only(top: 130.h),
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              BlocBuilder<PostsCubit, PostsState>(
                                builder: (context, state) {
                                  var cubit = context.read<PostsCubit>();

                                  if (state is PostsError) {
                                    return NetWorkError(
                                      onPressed: () {
                                        String id = CacheHelper.getString(
                                          key: "uid",
                                        );
                                        cubit.getAllPostsOfUser(id);
                                      },
                                    );
                                  }
                                  final isLoading = state is PostsLoading;

                                  final posts = isLoading
                                      ? List.generate(3, (_) => FakePost.fake())
                                      : state is PostsLoaded
                                      ? state.posts
                                      : [];

                                  return ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Skeletonizer(
                                        enabled: isLoading,
                                        child: PostItem(post: posts[index]),
                                      );
                                    },
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: posts.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox.shrink();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 80.h,
                          child: Center(
                            child: state is ProfileLoading
                                ? Skeletonizer(
                              enabled: true,
                              child: ProfileHeader(
                                id: widget.id,
                                user: User(
                                  id: "asd",
                                  firstName: "asdasd",
                                  lastName: "asdad",
                                  avatar:
                                  "https://sm.ign.com/t/ign_pk/cover/a/avatar-gen/avatar-generations_rpge.1200.jpg",
                                ),
                              ),
                            )
                                : ProfileHeader(user: user, id: widget.id),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
  }
}

/*
*    const Text(
                          "الادارة",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.subtitle,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SectionCard(
                          icon: Icons.directions_car,
                          title: "سجل الحجوزات",
                          subtitle: "يمكنك معرفة سجل حجوزاتك من هنا",
                        ),
                        const SectionCard(
                          icon: Icons.credit_card,
                          title: "طرق الدفع",
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "التخصيصات",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.subtitle,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SectionCard(
                          icon: Icons.settings,
                          title: "الاعدادات",
                          subtitle: "اعدادات التطبيق",
                        ),
                        SectionCard(
                          icon: Icons.notifications,
                          title: "الاشعارات",
                          trailing: Switch(
                            value: true,
                            onChanged: (_) {},
                            activeColor: AppColors.primary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "المساعدة",
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.subtitle,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const SectionCard(
                          icon: Icons.help_outline,
                          title: "المساعدة والدعم الفني",
                        ),
                        const LogoutButton(),
                        const Center(
                          child: Text(
                            "الاصدار 1.0.0",
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.subtitle,
                            ),
                          ),
                        ),*/
