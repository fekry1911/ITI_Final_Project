import 'package:flutter/material.dart';
import '../../data/model/microbus_models.dart';

class BusCard extends StatelessWidget {
  final Microbus bus;

  const BusCard({super.key, required this.bus});

  @override
  Widget build(BuildContext context) {
    // Derived/Mocked properties for UI matching
    final bool isFull = bus.availableSeats == 0;
    final bool isBusy = bus.availableSeats < (bus.capacity * 0.2); // generic logic
    
    // Status visual mapping
    String statusText = "Running";
    Color statusColor = const Color(0xFFE8F5E9); // Light Green
    Color statusTextColor = const Color(0xFF43A047); // Green
    
    if (isFull) {
      statusText = "FULL";
      statusColor = const Color(0xFFFFEBEE); 
      statusTextColor = const Color(0xFFE53935);
    } else if (isBusy) {
      statusText = "Busy";
      statusColor = const Color(0xFFFFF3E0);
      statusTextColor = const Color(0xFFFB8C00);
    }

    // Capacity progress
    final int booked = bus.capacity - bus.availableSeats;
    final double capacityProgress = bus.capacity > 0 ? booked / bus.capacity : 0.0;
    
    Color progressColor = const Color(0xFF2962FF);
    if (isFull) progressColor = const Color(0xFFE53935);
    else if (isBusy) progressColor = const Color(0xFFFB8C00);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Status + Time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: statusTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    " • ${bus.isAirConditioned ? "AC" : "Non-AC"} • On Time", // Placeholder for time
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, color: Colors.grey[300], size: 16),
              ],
            ),
            const SizedBox(height: 12),

            // Bus Name & Route
            Row(
              children: [
                Text(
                  "Bus ${bus.plateNumber}", // Using plate as Bus Number
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "${bus.line.fromStation.stationName} - ${bus.line.toStation.stationName}",
                    style: TextStyle(color: Colors.grey[500]),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Capacity Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Capacity", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                Text(
                  "$booked / ${bus.capacity}",
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: capacityProgress,
                backgroundColor: Colors.grey[100],
                color: progressColor,
                minHeight: 6,
              ),
            ),
             // Alert line if max capacity or close to it
            if (isFull)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, size: 16, color: const Color(0xFFE53935)),
                    const SizedBox(width: 4),
                    Text(
                      "Max Capacity Reached",
                      style: TextStyle(color: const Color(0xFFE53935), fontSize: 12),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Driver & Location
            Row(
              children: [
                // Avatar
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: NetworkImage("https://cdn-icons-png.flaticon.com/512/3135/3135715.png"), // Generic avatar
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "DRIVER",
                        style: TextStyle(color: Colors.grey[400], fontSize: 10, letterSpacing: 1),
                      ),
                      Text(
                        bus.driverName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.location_on, size: 18, color: const Color(0xFF2962FF)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    bus.currentStatus.isNotEmpty ? bus.currentStatus : "In Transit",
                    style: TextStyle(color: Colors.blueGrey[700], fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
