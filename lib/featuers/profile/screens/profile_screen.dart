import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/profile/screens/widgets/profile_header.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/const/const_paths.dart';
import '../../../core/helpers/cach_helper.dart';
import '../../../core/models/user_model.dart';
import '../../../core/shared_widgets/error_page.dart';
import '../../../core/shared_widgets/login_first.dart';
import '../../../core/shared_widgets/toast.dart';
import '../../../core/theme/color/colors.dart';
import '../../community/data/model/fake_data/model.dart';
import '../../community/screens/widgets/post_card.dart';
import '../logic/posts_cubit.dart';
import '../logic/profile_cubit.dart';

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
      return LoginFirst();
    } else {
      return Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        body: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification.metrics.pixels >=
                notification.metrics.maxScrollExtent - 200) {
              if (context.read<PostsCubit>().lastPage !=
                  context.read<PostsCubit>().page) {
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
                sucssesToast(
                  context,
                  "تم تسجيل الخروج بنجاح",
                  "نراك قريبا دمتم سالمين",
                );
              }
              if (state is ProfileError) {
                errorToast(context, "مشكله ف تسجيل الخروج", state.message);
              }
            },
            child: BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final user = state is ProfileLoaded ? state.user : null;
                return CustomScrollView(
                  controller: scrollController,
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      expandedHeight: 200.h,
                      pinned: true,
                      stretch: true,
                      backgroundColor: AppColors.primary,
                      leading: CacheHelper.getString(key: "userId") != widget.id
                          ? BackButton(color: Colors.white)
                          : IconButton(
                              onPressed: () {
                                context.read<ProfileCubit>().logout();
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.signOut,
                                color: Colors.white,
                              ),
                            ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.mainColor,
                                AppColors.blackColor,

                              ],
                            ),
                          ),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              // Optional: Add a pattern or image opacity here
                              Opacity(
                                opacity: 0.1,
                                child: Image.asset(
                                  "assets/images/pattern.png", // Assuming you have a pattern or use a standard one
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => SizedBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Container(
                              child: state is ProfileLoading
                                  ? Skeletonizer(
                                      enabled: true,
                                      child: ProfileHeader(
                                        id: widget.id,
                                        user: User(
                                          id: "asd",
                                          firstName: "Loading...",
                                          lastName: "",
                                          avatar: "",
                                        ),
                                      ),
                                    )
                                  : ProfileHeader(user: user, id: widget.id),
                            ),
                          ).animate().fadeIn(duration: 500.ms).moveY(
                                begin: 50,
                                end: 0,
                                curve: Curves.easeOut,
                              ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ),
                    BlocBuilder<PostsCubit, PostsState>(
                      builder: (context, state) {
                        var cubit = context.read<PostsCubit>();

                        if (state is PostsError &&
                            state.message != "لا يوجد اتصال بالإنترنت") {
                          return SliverToBoxAdapter(
                            child: NetWorkError(
                              error: state.message,
                              onPressed: () {
                                cubit.getAllPostsOfUser(widget.id);
                              },
                            ),
                          );
                        }
                        final isLoading = state is PostsLoading;

                        final posts = isLoading
                            ? List.generate(3, (_) => FakePost.fake())
                            : state is PostsLoaded
                                ? state.posts
                                : [];
                        
                        // Handle empty state
                        if (!isLoading && posts.isEmpty) {
                           return SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(top: 50.h),
                              child: Column(
                                children: [
                                  Icon(Icons.post_add, size: 60, color: Colors.grey.withOpacity(0.5)),
                                  SizedBox(height: 10),
                                  Text("لا توجد منشورات بعد", style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ).animate().fadeIn(),
                          ); 
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 8.h,
                                ),
                                child: Skeletonizer(
                                  enabled: isLoading,
                                  child: PostItem(post: posts[index]),
                                ),
                              ).animate().fadeIn(
                                    delay: (100 * index).ms,
                                    duration: 500.ms,
                                  ).slideX(begin: 0.2, end: 0);
                            },
                            childCount: posts.length,
                          ),
                        );
                      },
                    ),
                    SliverPadding(padding: EdgeInsets.only(bottom: 20.h)),
                  ],
                );
              },
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
