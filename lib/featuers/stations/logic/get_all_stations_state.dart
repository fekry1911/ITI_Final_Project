import 'package:geolocator/geolocator.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../data/model/stations_model.dart';

@immutable
sealed class GetAllStationsState extends Equatable {}

final class GetAllStationsInitial extends GetAllStationsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllStationsLoading extends GetAllStationsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllStationsSuccess extends GetAllStationsState {
  final List<SimpleStationData> stations;
  final Position? userPosition;

  GetAllStationsSuccess(this.stations, this.userPosition);

  @override
  // TODO: implement props
  List<Object?> get props => [stations, userPosition];
}

final class GetAllStationsError extends GetAllStationsState {
  final String error;

  GetAllStationsError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
