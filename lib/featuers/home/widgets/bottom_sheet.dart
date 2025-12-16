import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/home/widgets/recent_route_card.dart';
import 'package:iti_moqaf/featuers/home/widgets/search_field.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.1,
      maxChildSize: 0.6,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController,
            children: [
              // Handle
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: SearchField(
                  onTap: () {
                    print("Search tapped");
                  },
                  onMicTap: () {
                    print("Mic tapped");
                  },
                ),
              ),

              SizedBox(height: 24.h),

              Row(
                children: [
                  Text(
                    "آخر المسارات",
                    style: AppTextStyle.font24BlackSemiBold.copyWith(
                      fontSize: 18.sp,
                    ),
                  ),
                  Spacer(),
                  InkWell(

                    child: Text(
                      "عرض الكل",
                      style: AppTextStyle.font18GreyRegular.copyWith(
                        color: AppColors.mainColor,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              RecentRouteCard(
                title: "من البيت للشغل",
                subtitle: "أتوبيس 42 • يتحرك كمان 8 دقايق",
                statusText: "في المعاد",
                statusColor: Colors.green,
                onTap: () {
                  print("Route tapped");
                },
              ),
              SizedBox(height: 10.h),

              RecentRouteCard(
                title: "من البيت للشغل",
                subtitle: "أتوبيس 42 • يتحرك كمان 8 دقايق",
                statusText: "في المعاد",
                statusColor: Colors.green,
                onTap: () {
                  print("Route tapped");
                },
              ),
              SizedBox(height: 10.h),
              RecentRouteCard(
                title: "من البيت للشغل",
                subtitle: "أتوبيس 42 • يتحرك كمان 8 دقايق",
                statusText: "في المعاد",
                statusColor: Colors.green,
                onTap: () {
                  print("Route tapped");
                },
              ),
              SizedBox(height: 10.h),
              RecentRouteCard(
                title: "من البيت للشغل",
                subtitle: "أتوبيس 42 • يتحرك كمان 8 دقايق",
                statusText: "في المعاد",
                statusColor: Colors.green,
                onTap: () {
                  print("Route tapped");
                },
              ),
              SizedBox(height: 10.h),
              RecentRouteCard(
                title: "من البيت للشغل",
                subtitle: "أتوبيس 42 • يتحرك كمان 8 دقايق",
                statusText: "في المعاد",
                statusColor: Colors.green,
                onTap: () {
                  print("Route tapped");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildItem(String title) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(title),
    );
  }
}
