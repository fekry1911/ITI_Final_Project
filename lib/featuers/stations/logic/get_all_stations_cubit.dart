import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/stations/data/model/repo/get_all_stations-repo.dart';
import 'package:iti_moqaf/featuers/stations/data/model/stations_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/determine_position.dart';
import 'get_all_stations_state.dart';


class GetAllStationsCubit extends Cubit<GetAllStationsState> {
  final GetAllStationsRepo getAllStationsRepo;

  GetAllStationsCubit(this.getAllStationsRepo) : super(GetAllStationsInitial());
  

  Future<void> getAllStations() async {
    emit(GetAllStationsLoading());
    try {
      Position? position;
      try {
        position = (await determinePosition()) as Position?;
      } catch (e) {
        print("Location error: $e");
      }
      
      final result = await getAllStationsRepo.getAllStations(page:1, limit: 30);
      if (result is ApiSuccess<SimpleStationsResponse>) {
        print(result.data.data);
        final List<SimpleStationData> stations = result.data.data;
        emit(GetAllStationsSuccess(stations, position));
      } else if (result is ApiError<SimpleStationsResponse>) {
        print(result.message);
        print(result.message);
        emit(GetAllStationsError(result.message));
      }
    } catch (e) {
      emit(GetAllStationsError(e.toString()));
    }
  }
}
