import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/stations/data/model/repo/get_all_stations-repo.dart';
import 'package:iti_moqaf/featuers/stations/data/model/stations_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import 'get_all_stations_state.dart';


class GetAllStationsCubit extends Cubit<GetAllStationsState> {
  final GetAllStationsRepo getAllStationsRepo;

  GetAllStationsCubit(this.getAllStationsRepo) : super(GetAllStationsInitial());
  
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getAllStations() async {
    emit(GetAllStationsLoading());
    try {
      Position? position;
      try {
        position = await _determinePosition();
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
