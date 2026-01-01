part of 'search_stations_cubit.dart';

abstract class SearchStationsState {}

class SearchStationsInitial extends SearchStationsState {}

class SearchStationsLoading extends SearchStationsState {}

class SearchStationsLoaded extends SearchStationsState {
  final List<SimpleStationData> stations;

  SearchStationsLoaded(this.stations);
}

class SearchStationsError extends SearchStationsState {
  final String message;

  SearchStationsError(this.message);
}
