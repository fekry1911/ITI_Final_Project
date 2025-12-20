import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';

import '../model/near_stations_model.dart';

class GetNearbyStationsRepo{
  ApiService apiService;
  GetNearbyStationsRepo(this.apiService);

  Future<ApiResult<StationsResponseModel>> fetNearpyStations(double lat,double long ,double distance){
    return apiService.getAllNearbyStations(lat, long, distance);
  }
}