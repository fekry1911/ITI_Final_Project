import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/featuers/line_details/data/model/microbus_models.dart';
import 'package:iti_moqaf/featuers/line_details/logic/get_details_of_line_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'widgets/bus_card.dart';

class LineDetails extends StatelessWidget {
  String stationId;
  String lineId;

  LineDetails({required this.stationId, required this.lineId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light grey background
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

          if (state is GetDetailsOfLineSuccess) {
            buses = state.results;
          } else if (state is GetDetailsOfLineLoading) {
            isLoading = true;
            // Create dummy data for skeleton loading
            buses = List.generate(
              5,
              (index) => Microbus(
                id: 'dummy',
                model: 'Microbus Model',
                plateNumber: '123 ABC',
                driverName: 'Driver Name',
                capacity: 14,
                isAirConditioned: true,
                currentStatus: 'Running',
                line: LineData(
                  id: 'line1',
                  fromStation: StationData(id: 's1', stationName: 'Station A'),
                  toStation: StationData(id: 's2', stationName: 'Station B'),
                ),
                version: 0,
                bookedUsers: [],
                availableSeats: 5,
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
