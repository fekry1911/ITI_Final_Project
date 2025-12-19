part of 'get_one_station_cubit.dart';

@immutable
sealed class GetOneStationState extends Equatable {}

final class GetOneStationInitial extends GetOneStationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetOneStationLoading extends GetOneStationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetOneStationSuccess extends GetOneStationState {
  final StationModel stationModel;

  GetOneStationSuccess(this.stationModel);

  @override
  // TODO: implement props
  List<Object?> get props => [stationModel];
}

final class GetOneStationError extends GetOneStationState {
  final String error;

  GetOneStationError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
