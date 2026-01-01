import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/community/screens/community.dart';
import 'package:iti_moqaf/featuers/home/logic/home_cubit.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/screen.dart';
import 'package:iti_moqaf/featuers/profile/screens/profile_screen.dart';
import 'package:iti_moqaf/featuers/stations/screens/StationsScreen.dart';

import '../../../core/theme/color/colors.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<Widget> screens = [
    NearStations(),
    StationsScreen(),
    Community(),
    ProfileScreen(id: CacheHelper.getString(key: "userId") ?? ""),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.watch<HomeCubit>();
        int index = cubit.index;
        return Scaffold(
          extendBody: true,
          appBar: index == 0 || index == 3
              ? null
              : AppBar(
            actions: index == 2
                ? [
              IconButton(
                onPressed: () {
                  context.pushNamed(
                    allChatsScreen,
                    arguments:
                    CacheHelper.getString(key: "userId") ?? "",
                  );
                },
                icon: SvgPicture.asset(
                  "assets/svg_icons/send.svg",
                  color: AppColors.mainColor,
                ),
                color: AppColors.primary,
              ),
            ]
                : [],
            title: Text(
              index == 1 ? "جميع المحطات" : "شارك بمساعده او مشكلتك",
            ),
            centerTitle: false,
          ),

          body: IndexedStack(index: cubit.index, children: screens),
          floatingActionButton: Transform.translate(
            offset: Offset(0, 10.h),
            child: Container(
              height: 64.r,
              width: 64.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryDark],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: () {
                  context.pushAndRemoveUntil(homeScreen);
                },
                icon: FaIcon(
                  FontAwesomeIcons.rotate,
                  size: 24.r,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            height: 60.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Glass background
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(100.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.08),
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // BottomNavigationBar
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.r),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: cubit.index,
                    selectedItemColor: AppColors.primary,
                    unselectedItemColor: AppColors.textSecondary.withOpacity(
                      0.5,
                    ),
                    showUnselectedLabels: false,
                    selectedIconTheme: IconThemeData(size: 24.r),
                    unselectedIconTheme: IconThemeData(size: 22.r),
                    items: [
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/svg_icons/solid_home.svg',
                          color: AppColors.primary,
                          width: 24,
                        ),
                        icon: SvgPicture.asset(
                          'assets/svg_icons/stroke_home.svg',
                          color: AppColors.greyText,

                          width: 24,
                        ),
                        label: "Home",
                      ),
                      const BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.busSimple),
                        label: "Stations",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/svg_icons/community.svg',
                          color: AppColors.primary,
                          width: 35,
                        ),
                        icon: SvgPicture.asset(
                          'assets/svg_icons/community.svg',
                          color: AppColors.greyText,

                          width: 30,
                        ),
                        label: "Feeds",
                      ),
                      BottomNavigationBarItem(
                        activeIcon: SvgPicture.asset(
                          'assets/svg_icons/solid_profile.svg',
                          color: AppColors.primary,
                          width: 30,
                        ),
                        icon: SvgPicture.asset(
                          'assets/svg_icons/stroke_profile.svg',
                          color: AppColors.greyText,
                          width: 24,
                        ),
                        label: "Profile",
                      ),
                    ],
                    onTap: (index) {
                      cubit.changeIndex(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}