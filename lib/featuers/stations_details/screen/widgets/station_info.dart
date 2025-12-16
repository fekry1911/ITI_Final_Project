import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/color/colors.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

class StationInfo extends StatelessWidget {
  const StationInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      borderOnForeground: true,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Flexible(
                            child: Text(
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              "موقف المنوفية (شبين الكوم)",
                              style: AppTextStyle.font30BlackBold.copyWith(
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            padding: EdgeInsets.all(6.h),
                            child: Text(
                              "نشط",
                              style: AppTextStyle.font11BlackRegular.copyWith(
                                color: AppColors.whiteColor
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 15.r,
                            color: AppColors.lightGreen,
                          ),
                          Text(
                            "موقف السلام الجديد",
                            style: AppTextStyle.font18GreyRegular.copyWith(
                              color: AppColors.lightGreen,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Divider(color: AppColors.mainColor, thickness: 1.3),
            Row(
              children: [
                Text(
                  "عدد المسارات",
                  style: AppTextStyle.font18WhiteMedium.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                Spacer(),
                Text(
                  "20",
                  style: AppTextStyle.font14BlackRegular.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
