import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RouteDetails extends StatelessWidget {
   RouteDetails({super.key,required this.distance,required this.duration});
  String distance;
  String duration;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Icon(Icons.watch_later_outlined),
            SizedBox(width: 3.w,),

            Text(duration),
          ],
        ),
        SizedBox(width: 6.h,),


        Row(
          children: [
            Icon(Icons.social_distance),
            SizedBox(width: 3.w,),

            Text(distance),
          ],
        )
      ],
    );
  }
}
