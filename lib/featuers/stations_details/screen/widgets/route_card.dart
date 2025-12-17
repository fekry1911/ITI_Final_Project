import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
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
      elevation: 1,
      borderOnForeground: true,
      color: Colors.white,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.greyColor.withOpacity(.1),
          radius: 30,
          child: Icon(Icons.route, color: AppColors.greyColor.withOpacity(.7)),
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
                         style: AppTextStyle.font14BlackRegular
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
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(data["price"],style: AppTextStyle.font18WhiteMedium.copyWith(
                  fontSize: 10.sp
                ),textAlign: TextAlign.center,),
              )
              )
            ],
          ),
        ),
      ),
    ).animate().scaleXY(duration: 500.ms);
  }
}
