import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/const/const_paths.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/stations/data/model/stations_model.dart';

import '../../../../core/theme/color/colors.dart';

class StationCard extends StatelessWidget {
  StationCard({super.key, required this.data, required this.index});

  SimpleStationData data;
  int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      borderOnForeground: true,
      color: AppColors.whiteColor,
      child: ListTile(
        leading: data.status != "Issues"
            ? CircleAvatar(
                backgroundColor: AppColors.mainColor.withOpacity(.8),
                radius: 22.r,
                child: Icon(
                  Icons.train,
                  color: AppColors.whiteColor,
                  size: 22.r,
                ),
              )
            : CircleAvatar(
                backgroundColor: AppColors.greyColor.withOpacity(.1),
                radius: 30.r,
                child: Icon(
                  Icons.build_sharp,
                  color: AppColors.greyColor.withOpacity(.7),
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
                            data.stationName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.font14BlackRegular,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.circle,
                          size: 10.r,
                          color: data.status == "Issues"
                              ? AppColors.redColor
                              : Colors.green,
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    data.status == "Issues"
                        ? Text(
                            "مغلق للصيانه",
                            style: AppTextStyle.font14BlackRegular.copyWith(
                              color: AppColors.redColor,
                              fontSize: 9.sp,
                            ),
                          )
                        : Row(
                            children: [
                              Text(
                                " علي بعد} كم ",
                                style: AppTextStyle.font14BlackRegular.copyWith(
                                  color: Colors.grey.shade600,
                                  fontSize: 9.sp,
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
                                  " مسارات",
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
                Navigator.pushNamed(
                  context,
                  stationDetailsScreen,
                  arguments: data.id,
                );
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
    ).animate().scaleXY(duration: 500.ms);
  }
}
