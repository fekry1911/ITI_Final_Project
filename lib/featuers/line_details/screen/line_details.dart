import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/featuers/line_details/screen/widgets/bus_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../core/shared_widgets/network_error.dart';
import '../../../core/shared_widgets/no_trips_widget.dart'; // Added
import '../../../core/theme/color/colors.dart'; // Added
import '../data/model/microbus_models.dart';
import '../logic/get_details_of_line_cubit.dart';

class LineDetails extends StatelessWidget {
  String stationId;
  String lineId;

  LineDetails({required this.stationId, required this.lineId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // Light grey background
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Live Routes",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocConsumer<GetDetailsOfLineCubit, GetDetailsOfLineState>(
        listener: (context, state) {
          // Listen for side effects if needed
        },
        builder: (context, state) {
          List<Microbus> buses = [];
          bool isLoading = false;
            if (state is GetDetailsOfLineError) {
            if (state.message == "لا يوجد اتصال بالإنترنت") {
              return Expanded(
                child: Center(child: Column(
                  children: [
                    NetWorkErrorPage(),
                    Text("لا يوجد اتصال بالإنترنت"),
                  ],
                )),
              );}
              // Use NoTripsWidget for "No Buses" type errors or generic empty states if message implies it
            return Expanded(child: NoTripsWidget(message: state.message));
          }

          if (state is GetDetailsOfLineSuccess) {
            buses = state.results;
          } else if (state is GetDetailsOfLineLoading) {
            isLoading = true;
            buses = List.generate(
              5,
              (index) => Microbus(
                id: 'bus1',
                model: 'Mercedes Sprinter',
                plateNumber: 'ABC-1234',
                driverName: 'Ahmed Ali',
                capacity: 20,
                isAirConditioned: true,
                currentStatus: 'active',
                lines: [
                  LineData(
                    id: 'line1',
                    fromStation: StationData(
                      id: 'station1',
                      stationName: 'Cairo',
                    ),
                    toStation: StationData(id: 'station2', stationName: 'Giza'),
                  ),
                ],
                currentStation: StationData(
                  id: 'station1',
                  stationName: 'Cairo',
                ),
                createdAt: DateTime.now().subtract(Duration(days: 10)),
                updatedAt: DateTime.now(),
                version: 0,
                bookedUsers: [
                  BookedUser(
                    id: 'user1',
                    firstName: 'Mohamed',
                    lastName: 'Salah',
                    email: 'mohamed@example.com',
                    bookingStatus: 'confirmed',
                    bookingId: 'booking1',
                    bookedAt: DateTime.now().subtract(Duration(hours: 5)),
                  ),
                ],
                availableSeats: 19,
              ),
            );
          }

          int active = isLoading ? 14 : buses.length;
          int onTime = isLoading
              ? 10
              : buses.where((b) => b.currentStatus != 'Delayed').length;
          int delayed = isLoading
              ? 2
              : buses.where((b) => b.currentStatus == 'Delayed').length;

          return Skeletonizer(
            enabled: isLoading,
            child: Column(
              children: [
                // Bus List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: buses.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final bus = buses[index];
                      return BusCard(
                        bus: bus,
                        stationId: stationId,
                        lineId: lineId,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
