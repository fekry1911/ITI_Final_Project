import 'package:flutter/material.dart';

enum TravelMode { car, bike, walk }

extension TravelModeExt on TravelMode {
  IconData get icon {
    switch (this) {
      case TravelMode.car:
        return Icons.directions_car;
      case TravelMode.bike:
        return Icons.directions_bike;
      case TravelMode.walk:
        return Icons.directions_walk;
    }
  }

  String get label {
    switch (this) {
      case TravelMode.car:
        return 'سيارة';
      case TravelMode.bike:
        return 'دراجة';
      case TravelMode.walk:
        return 'مشي';
    }
  }
}

extension TravelModeProfile on TravelMode {
  String get profile {
    switch (this) {
      case TravelMode.car:
        return 'driving-car';
      case TravelMode.bike:
        return 'cycling-regular';
      case TravelMode.walk:
        return 'foot-walking';
    }
  }
}