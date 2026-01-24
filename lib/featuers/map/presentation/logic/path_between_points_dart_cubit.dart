import 'package:bloc/bloc.dart';
import 'package:iti_moqaf/featuers/map/data/models/route_response.dart';
import 'package:iti_moqaf/featuers/map/presentation/screen/map.dart';
import 'package:meta/meta.dart';

import '../../../../core/networking/api_result.dart';
import '../../domain/repo/get_route.dart';

part 'path_between_points_dart_state.dart';

class PathBetweenPointsDartCubit extends Cubit<PathBetweenPointsDartState> {
  GetRoute getRoute;

  PathBetweenPointsDartCubit(this.getRoute)
    : super(PathBetweenPointsDartState.initial());



  Future<void> getAllGeometry({
    required List<List<double>> coordinates,
    required TravelMode mode,
  }) async {
    emit(state.copyWith(isLoading: true, mode: mode));

    final response =
    await getRoute.getAllGeometry(coordinates: coordinates, mode: mode);

    if (response is ApiSuccess<Feature>) {
      emit(state.copyWith(isLoading: false, data: response.data));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
