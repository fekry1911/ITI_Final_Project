import 'package:iti_moqaf/core/networking/api_result.dart';

import '../../data/models/mode.dart';
import '../../data/models/route_response.dart';
import '../../data/source/service.dart';
import '../../presentation/screen/map.dart';

abstract class GetRoute {
  Future<ApiResult<Feature>> getAllGeometry({
    required List<List<double>> coordinates,
    required TravelMode mode,

  });
}
