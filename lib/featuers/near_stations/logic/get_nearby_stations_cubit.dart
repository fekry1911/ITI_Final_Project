import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_nearby_stations_state.dart';

class GetNearbyStationsCubit extends Cubit<GetNearbyStationsState> {
  GetNearbyStationsCubit() : super(GetNearbyStationsInitial());
}
