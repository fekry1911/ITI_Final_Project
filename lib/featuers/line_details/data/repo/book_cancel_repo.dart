import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';

import '../model/book_response_model.dart';

class BookAndCancelRepo {
  ApiService apiService;

  BookAndCancelRepo(this.apiService);

  Future<ApiResult<SeatBookingResponse>> bookSeatRepo({
    required String vehicleId,
    required String lineId,
    required String stationId,
  }) async {
    return await apiService.bookSeatInVehicle(
      vehicleId: vehicleId,
      lineId: lineId,
      stationId: stationId,
    );
  }

  Future<ApiResult<SeatBookingResponse>> cancelBookSeatRepo({
    required String vehicleId,
    required String lineId,
    required String stationId,
  }) async {
    return await apiService.cancelBookSeatInVehicle(
      vehicleId: vehicleId,
      lineId: lineId,
      stationId: stationId,
    );
  }

  Future<ApiResult<String>> confirmBookRepo({required String sessionId}) async {
    return apiService.confirmBook(sessionId: sessionId);
  }
}
