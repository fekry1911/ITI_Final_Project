import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/theme/color/colors.dart';
import '../../../../near_stations/data/model/near_stations_model.dart';
import '../../../data/models/mode.dart';
import '../../logic/path_between_points_dart_cubit.dart';
import '../map.dart';

class TravelModeSelector extends StatelessWidget {
  const TravelModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  final TravelMode selectedMode;
  final ValueChanged<TravelMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: TravelMode.values.map((mode) {
        final isSelected = mode == selectedMode;

        return GestureDetector(
          onTap: () => onModeChanged(mode),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color:
              isSelected ? AppColors.mainColor : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Icon(
                  mode.icon,
                  color:
                  isSelected ? Colors.white : Colors.black54,
                ),
                const SizedBox(width: 6),
                Text(
                  mode.label,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}


