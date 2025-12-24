import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/line_details/data/repo/get_line_details_repo.dart';
import 'package:meta/meta.dart';

import '../data/model/microbus_models.dart';

part 'get_details_of_line_state.dart';

class GetDetailsOfLineCubit extends Cubit<GetDetailsOfLineState> {
  GetLineDetailsRepo getLineDetailsRepo;

  GetDetailsOfLineCubit(this.getLineDetailsRepo)
    : super(GetDetailsOfLineInitial());

  Future<void> getLineDetails(String lineId, String stationId) async {
    emit(GetDetailsOfLineLoading());
    final result = await getLineDetailsRepo.getLineDetails(lineId, stationId);
    if (result is ApiSuccess<MicrobusResponse>) {
      print(result.data.count);
      print(result.data.results);
      print(result.data.results);
      emit(GetDetailsOfLineSuccess(result.data.results));
    } else if (result is ApiError<MicrobusResponse>) {
      emit(GetDetailsOfLineError(result.message));
    }
  }
}
