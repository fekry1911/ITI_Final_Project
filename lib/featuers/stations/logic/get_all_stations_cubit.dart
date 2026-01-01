import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/stations/data/model/repo/get_all_stations-repo.dart';
import 'package:iti_moqaf/featuers/stations/data/model/stations_model.dart';

import '../../../core/utils/determine_position.dart';
import 'get_all_stations_state.dart';

class GetAllStationsCubit extends Cubit<GetAllStationsState> {
  final GetAllStationsRepo getAllStationsRepo;

  GetAllStationsCubit(this.getAllStationsRepo) : super(GetAllStationsInitial());

  List<SimpleStationData> _allStations = [];
  bool isFetching = false;
  bool hasMore = true;
  int page = 1;
  int lastPage = 0;

  Future<void> getAllStations() async {
    if (isFetching || !hasMore) return;

    isFetching = true;

    if (page == 1) {
      emit(GetAllStationsLoading());
    }

    try {
      Position? position;
      try {
        position = (await determinePosition()) as Position?;
      } catch (_) {}

      final result = await getAllStationsRepo.getAllStations(page: page);

      if (result is ApiSuccess<SimpleStationsResponse>) {
        lastPage = result.data.lastPage;
        final newStations = result.data.data;

        if (newStations.isEmpty) {
          hasMore = false;
        } else {
          page++;
          _allStations.addAll(newStations);
        }

        emit(GetAllStationsSuccess(List.from(_allStations), position, hasMore));
      } else if (result is ApiError<SimpleStationsResponse>) {
        if (_allStations.isNotEmpty) {
          // If we have data, keep showing it and just stop loading
          hasMore = false; 
          emit(GetAllStationsSuccess(List.from(_allStations), position, hasMore));
        } else {
          emit(GetAllStationsError(result.message));
        }
      }
    } catch (e) {
      emit(GetAllStationsError(e.toString()));
    } finally {
      isFetching = false;
    }
  }
}
