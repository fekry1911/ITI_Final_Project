
import '../../../../core/networking/api_result.dart';
import '../../../../core/networking/api_service.dart';
import '../model/microbus_models.dart';

class GetLineDetailsRepo {
  ApiService apiService;

  GetLineDetailsRepo(this.apiService);

  Future<ApiResult<MicrobusResponse>> getLineDetails(
    String lineId,
    String stationId,
  ) => apiService.getVehicles(lineId, stationId);
}
