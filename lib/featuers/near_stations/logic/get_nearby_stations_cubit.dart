import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:meta/meta.dart';

import '../../../core/utils/determine_position.dart';
import '../data/model/near_stations_model.dart';
import '../data/repo/get_nearby_stations.dart';

part 'get_nearby_stations_state.dart';

class GetNearbyStationsCubit extends Cubit<GetNearbyStationsState> {
  GetNearbyStationsRepo getNearbyStationsRepo;
  GetNearbyStationsCubit(this.getNearbyStationsRepo) : super(GetNearbyStationsInitial());


  Future<void> getNearbyStations() async {
    emit(GetNearbyStationsLoading());
    try {
      Position position = (await determinePosition()) as Position;

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
