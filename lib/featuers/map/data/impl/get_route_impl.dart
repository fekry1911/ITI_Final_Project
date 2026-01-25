import 'package:iti_moqaf/core/networking/api_result.dart';

import 'package:iti_moqaf/featuers/map/data/models/route_response.dart';

import 'package:iti_moqaf/featuers/map/data/source/service.dart';

import '../../domain/repo/get_route.dart';
import '../../presentation/screen/map.dart';
import '../models/mode.dart';

class GetRouteImpl implements GetRoute{
  GetData data;
  GetRouteImpl(this.data);


  @override
  Future<ApiResult<Feature>> getAllGeometry({
    required List<List<double>> coordinates,
    required TravelMode mode,
  }) async {
    var response =
    await data.getRouteData(coordinates: coordinates, mode: mode);

    if (response is ApiSuccess<RouteResponse>) {
      return ApiSuccess(response.data.features.first);
    } else {
      return ApiError("لا يوجد اتصال بالإنترنت");
    }
  }

}