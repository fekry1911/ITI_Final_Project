import '../../../../../core/networking/api_result.dart';
import '../../../../../core/networking/api_service.dart';
import '../stations_model.dart';

class GetAllStationsRepo {
  final ApiService apiService;

  GetAllStationsRepo(this.apiService);

  Future<ApiResult<SimpleStationsResponse>> getAllStations({
    required int page,
  }) async {
   var reponse = await apiService.getAllStations(
      page: page,
    );
   return reponse;
  }
  Future<ApiResult<SimpleStationsResponse>> getAllStationsWithoutPagination() async {
    return await apiService.getAllStations(page: 1, limit: 10000);
  }
}
