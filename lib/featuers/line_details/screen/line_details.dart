import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/featuers/line_details/logic/get_details_of_line_cubit.dart';
import 'package:iti_moqaf/featuers/line_details/data/model/microbus_models.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'widgets/status_chip.dart';
import 'widgets/bus_card.dart';

class LineDetails extends StatelessWidget {
  const LineDetails({super.key});

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
          style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
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
          int onTime = isLoading ? 10 : buses.where((b) => b.currentStatus != 'Delayed').length;
          int delayed = isLoading ? 2 : buses.where((b) => b.currentStatus == 'Delayed').length;

          return Skeletonizer(
            enabled: isLoading,
            child: Column(
              children: [
                // Search Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search by bus number or route...",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      suffixIcon: Icon(Icons.tune, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),

                // Status Filters
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      StatusChip(
                        icon: Icons.directions_bus,
                        label: "$active Active",
                        color: const Color(0xFFE3F2FD), // Light Blue
                        textColor: const Color(0xFF1E88E5), // Blue
                      ),
                      const SizedBox(width: 12),
                      StatusChip(
                        icon: Icons.check_circle,
                        label: "$onTime On Time",
                        color: const Color(0xFFE8F5E9), // Light Green
                        textColor: const Color(0xFF43A047), // Green
                      ),
                      const SizedBox(width: 12),
                      StatusChip(
                        icon: Icons.warning,
                        label: "$delayed Delayed",
                        color: const Color(0xFFFFEBEE), // Light Red
                        textColor: const Color(0xFFE53935), // Red
                      ),
                    ],
                  ),
                ),

                // Bus List
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: buses.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final bus = buses[index];
                      return BusCard(bus: bus);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2962FF), // Bright Blue
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
