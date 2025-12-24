import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/featuers/home/logic/home_cubit.dart';

import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/featuers/community/screens/community.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/screen.dart';
import 'package:iti_moqaf/featuers/profile/screens/profile_screen.dart';
import 'package:iti_moqaf/featuers/stations/screens/StationsScreen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  List<Widget> screens = [
    NearStations(),
    StationsScreen(),
    Community(),
    ProfileScreen(id: CacheHelper.getString(key: "userId"),),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = context.watch<HomeCubit>();
        return Scaffold(
          extendBody: true,
          body: IndexedStack(index: cubit.index, children: screens),
          floatingActionButton: Transform.translate(
            offset: Offset(0, 10.h),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: Container(
                  height: 56.r,
                  width: 56.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.35),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.4),
                      width: 0.6,
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.pushNamed(homeScreen);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.refresh,
                      size: 28.r,
                      color: Colors.black,
                    ),
                  ),
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
                    selectedItemColor: Colors.black,
                    unselectedItemColor: Colors.black.withOpacity(0.5),
                    showUnselectedLabels: false,
                    items: const [
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.house),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.bus),
                        label: "Search",
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.comments),

                        label: "Community",
                      ),
                      BottomNavigationBarItem(
                        icon: FaIcon(FontAwesomeIcons.person),
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
