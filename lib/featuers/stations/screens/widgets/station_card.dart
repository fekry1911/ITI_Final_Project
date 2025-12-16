import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/helpers/extentions/context_extentions.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';

import '../../../../core/theme/color/colors.dart';

class StationCard extends StatelessWidget {
  StationCard({super.key, required this.data});

  dynamic data;


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      borderOnForeground: true,
      color: AppColors.whiteColor,
      child: ListTile(
        leading: data["status"] != "Issues"
            ? CircleAvatar(
                backgroundColor: AppColors.mainColor,
                radius: 30.r,
                child: Icon(
                  Icons.train,
                  color: AppColors.whiteColor,
                  size: 25.r,
                ),
              )
            : CircleAvatar(
                backgroundColor: AppColors.lightGrey,
                radius: 30.r,
                child: Icon(
                  Icons.build_sharp,
                  color: AppColors.greyColor,
                  size: 25.r,
                ),
              ),
        title: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            data["name"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.font24BlackSemiBold.copyWith(
                              fontSize: 17.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.circle,
                          size: 10.r,
                          color: data["status"] == "Issues"
                              ? AppColors.redColor
                              : Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    data["status"] == "Issues"
                        ? Text(
                            "مغلق للصيانه",
                            style: AppTextStyle.font15GreyRegular.copyWith(
                              color: AppColors.redColor,
                            ),
                          )
                        : Row(
                            children: [
                              Text(
                                " علي بعد ${data["distance"]} كم ",
                                style: AppTextStyle.font15GreyRegular.copyWith(
                                  color: AppColors.lightGreen,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              Icon(
                                Icons.circle,
                                color: AppColors.lightGrey,
                                size: 4.r,
                              ),
                              SizedBox(width: 5.w),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.badgeColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                padding: EdgeInsets.all(3.h),
                                child: Text(
                                  "${data["routesCount"]} مسارات",
                                  style: AppTextStyle.font11BlackRegular
                                      .copyWith(color: AppColors.lightGreen),
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                context.pushNamed(stationDetailsScreen);
              },
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
                color: AppColors.lightGrey,
                size: 20.r,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
