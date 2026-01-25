import 'package:dio/dio.dart';

import '../../../../core/const/api_const.dart';
import '../../../../core/networking/api_result.dart';
import '../../presentation/screen/map.dart';
import '../models/mode.dart';
import '../models/route_response.dart';

class GetData {
  Dio api;

  GetData(this.api);

  Future<ApiResult<RouteResponse>> getRouteData({
    required List<List<double>> coordinates,
    required TravelMode mode,
  }) async {
    try {
      final response = await api.post(
        routePath(mode.profile),
        data: {"coordinates": coordinates},
      );

      RouteResponse routeResponse = RouteResponse.fromJson(response.data);
      return ApiSuccess(routeResponse);
    } catch (e) {
      return ApiError("لا يوجد اتصال بالإنترنت");
    }
  }

}
