import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iti_moqaf/featuers/home/widgets/bottom_sheet.dart';
import 'package:iti_moqaf/featuers/home/widgets/header.dart';
import 'package:iti_moqaf/featuers/home/widgets/map_chips.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return HomeBottomSheet();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),

            child: Image.network(
              "https://developers.google.com/static/maps/documentation/tile/images/example-basemap-tile.png",
              height: 1.sh,
              fit: BoxFit.fill,
            ),
          ),
          Header(),
          Positioned(
            top: 130.h,
            right: 80.w,
            child: MapInfoChip(
              icon: Icons.directions_bus_rounded,
              text: "12m",
              iconColor: Colors.blue,
            ),
          ),
          Positioned(
            top: 200.h,
            left: 80.w,
            child: MapInfoChip(
              icon: Icons.schedule_rounded,
              text: "Delayed",
              iconColor: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
