import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:iti_moqaf/featuers/home/logic/home_cubit.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit=context.read<HomeCubit>();
        return Scaffold(
          appBar:cubit.index==0?null: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          extendBody: true,
          body:cubit.screens[cubit.index],
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
                      cubit.setIndex(0);
                    },
                    icon: Icon(
                      Icons.location_on_outlined,
                      size: 28.r,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),

          floatingActionButtonLocation: FloatingActionButtonLocation
              .centerDocked,
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
                        icon:Icon(Iconsax.house),
                        label: "Home",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.transfer_within_a_station),
                        label: "Search",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.social_distance),
                        label: "Community",
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: "Settings",
                      ),
                    ],
                    onTap: (index) {
                      cubit.setIndex(index);
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
