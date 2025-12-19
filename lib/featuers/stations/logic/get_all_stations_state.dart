part of 'get_all_stations_cubit.dart';

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


  GetAllStationsSuccess(this.stations,);

  @override
  // TODO: implement props
  List<Object?> get props => [stations];
}

final class GetAllStationsError extends GetAllStationsState {
  final String error;

  GetAllStationsError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
