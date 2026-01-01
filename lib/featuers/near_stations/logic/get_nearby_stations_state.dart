part of 'get_nearby_stations_cubit.dart';

@immutable
sealed class GetNearbyStationsState extends Equatable {}

final class GetNearbyStationsInitial extends GetNearbyStationsState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

final class GetNearbyStationsLoading extends GetNearbyStationsState {
  @override
  // TODO: implement props
  List<Object?> get props =>[];
}

final class GetNearbyStationsSuccess extends GetNearbyStationsState {
  final List<NearStationModel> data;
  Position userPosition;

  GetNearbyStationsSuccess(this.data, this.userPosition);
  @override
  // TODO: implement props
  List<Object?> get props =>[data, userPosition];
}

final class GetNearbyStationsError extends GetNearbyStationsState {
  final String error;

  GetNearbyStationsError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props =>[error];
}


