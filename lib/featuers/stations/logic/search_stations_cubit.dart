import 'package:bloc/bloc.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/stations/data/model/repo/get_all_stations-repo.dart';
import 'package:iti_moqaf/featuers/stations/data/model/stations_model.dart';

part 'search_stations_state.dart';

class SearchStationsCubit extends Cubit<SearchStationsState> {
  final GetAllStationsRepo repo;
  List<SimpleStationData> _allStations = [];

  SearchStationsCubit(this.repo) : super(SearchStationsInitial());

  Future<void> getAllStations() async {
    emit(SearchStationsLoading());
    final result = await repo.getAllStationsWithoutPagination();

    if (result is ApiSuccess<SimpleStationsResponse>) {
      _allStations = result.data.data;
      emit(SearchStationsLoaded(_allStations));
    } else if (result is ApiError<SimpleStationsResponse>) {
      emit(SearchStationsError(result.message));
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(SearchStationsLoaded(_allStations));
      return;
    }

    final filtered = _allStations.where((station) {
      return station.stationName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    emit(SearchStationsLoaded(filtered));
  }
}
