import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:meta/meta.dart';

import '../data/model/near_stations_model.dart';
import '../data/repo/get_nearby_stations.dart';

part 'get_nearby_stations_state.dart';

class GetNearbyStationsCubit extends Cubit<GetNearbyStationsState> {
  GetNearbyStationsRepo getNearbyStationsRepo;
  GetNearbyStationsCubit(this.getNearbyStationsRepo) : super(GetNearbyStationsInitial());

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
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

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  Future<void> getNearbyStations() async {
    emit(GetNearbyStationsLoading());
    try {
      Position position = await _determinePosition();

      var result = await getNearbyStationsRepo.fetNearpyStations(
          position.latitude, position.longitude, 10000);

      if(result is ApiSuccess<StationsResponseModel>){
        emit(GetNearbyStationsSuccess(result.data.data, position));
      } else if(result is ApiError<StationsResponseModel>){
        emit(GetNearbyStationsError(result.message));
      }
    } catch(e){
      emit(GetNearbyStationsError(e.toString()));
    }
  }


}
