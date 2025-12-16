import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/core/shared_widgets/shared_text_form_field.dart';
import 'package:iti_moqaf/core/theme/text_theme/text_theme.dart';
import 'package:iti_moqaf/featuers/stations/screens/widgets/filter_widget.dart';
import 'package:iti_moqaf/featuers/stations/screens/widgets/station_card.dart';

import '../../../core/theme/color/colors.dart';
import '../data/model/data/filter_data.dart';
import '../data/model/data/statuins_data.dart';

class StationsScreen extends StatefulWidget {
  const StationsScreen({super.key});

  @override
  State<StationsScreen> createState() => _StationsscreenState();
}

class _StationsscreenState extends State<StationsScreen> {
  TextEditingController controller = TextEditingController();
  String fillter = filters[0]["label"]!;
  String valueFillter = filters[0]["value"]!;
  List? currentStations;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentStations=stationsData;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("المحطات", style: AppTextStyle.font30BlackBold),
        actions: [
          Container(margin: EdgeInsets.symmetric(horizontal: 10.w),
            child: CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              radius: 30,
              child: Icon(Icons.map,color: AppColors.mainColor,),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SharedTextFormField(
              controller: controller,
              hintText: "ابحث عن محطه",
              validator: (x) {},
              boderRaduis: 30.r,
              fillColor: AppColors.whiteColor,
              prefixIcon: Icon(Icons.search),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (context, index) => SizedBox(width: 10.w),
                itemBuilder: (context, index) {
                  String label = filters[index]["label"]!;
                  String value = filters[index]["value"]!;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        fillter = label;
                        valueFillter = value;

                        if (valueFillter == "All") {
                          currentStations = stationsData;
                        } else {
                          currentStations = stationsData
                              .where((station) => station["status"] == valueFillter)
                              .toList();
                        }
                      });
                    },
                    child: FilterWidget(
                      text: label,
                      backColor: fillter ==  label
                          ? AppColors.mainColor
                          : AppColors.whiteColor,
                      textColor:  fillter ==  label
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return StationCard(data: currentStations![index]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 5.h);
                },
                itemCount: currentStations!.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
