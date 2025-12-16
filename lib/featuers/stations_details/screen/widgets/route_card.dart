import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/stations_details/screen/widgets/route_details.dart';

import '../../../../core/theme/color/colors.dart';

class RouteCard extends StatelessWidget {
  RouteCard({super.key,required this.data});

  Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      borderOnForeground: true,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.lightGrey,
          radius: 30,
          child: Icon(Icons.route, color: AppColors.greyColor),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 0.w),
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   Row(
                     children: [
                       Text(
                         maxLines: 2,
                         overflow: TextOverflow.ellipsis,
                         data["name"],
                         style: AppTextStyle.font18BlackBold.copyWith(
                           fontSize: 15.sp,
                         ),
                       ),
                     ],
                   ),
                    SizedBox(height: 8.h,),
                    RouteDetails(distance:data["distance"],duration:data["duration"]),
                  ],
                ),
              ),
              Expanded(child:
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 5.h,horizontal: 3.w),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(data["price"],style: AppTextStyle.font18WhiteMedium.copyWith(
                  fontSize: 14.sp
                ),textAlign: TextAlign.center,),
              )
              )
            ],
          ),
        ),
      ),
    );
  }
}
