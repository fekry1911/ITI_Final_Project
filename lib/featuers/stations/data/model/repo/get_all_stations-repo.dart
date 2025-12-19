import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_service.dart';
import '../stations_model.dart';

class GetAllStationsRepo {
  final ApiService apiService;

  GetAllStationsRepo(this.apiService);

  Future<ApiResult<SimpleStationsResponse>> getAllStations({
    required int page,
    required int limit,
  }) {
   var reponse = apiService.getAllStations(
      page: page,
      limit: limit,
    );
   print(reponse.toString());
   return reponse;
  }
}
