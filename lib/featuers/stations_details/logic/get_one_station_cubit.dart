import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/networking/api_result.dart';
import '../data/model/station_model.dart';
import '../data/repo/get_one_station_repo.dart';

part 'get_one_station_state.dart';

class GetOneStationCubit extends Cubit<GetOneStationState> {
  GetOneStationRepo getOneStationRepo;

  GetOneStationCubit(this.getOneStationRepo) : super(GetOneStationInitial());

  Future<void> getOneStationById(id) async {
    emit(GetOneStationLoading());
    print(id);
    var result = await getOneStationRepo.getOneStationDetails(id);
    if (result is ApiSuccess<StationModel>) {
      emit(GetOneStationSuccess(result.data));
    } else if (result is ApiError<StationModel>) {
      print(result.message);
      emit(GetOneStationError(result.message));
    }
  }
}
