import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../model/station_model.dart';

class GetOneStationRepo{
  ApiService apiService;
  GetOneStationRepo(this.apiService);
  Future<ApiResult<StationModel>> getOneStationDetails(id){
    print("repo $id");
    return apiService.getOneStationDetails(id);
  }
}