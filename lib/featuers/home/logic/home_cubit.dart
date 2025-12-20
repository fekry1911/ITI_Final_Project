import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/core/di/di.dart';
import 'package:iti_moqaf/featuers/near_stations/logic/get_nearby_stations_cubit.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/screen.dart';
import 'package:iti_moqaf/featuers/profile/logic/profile_cubit.dart';
import 'package:iti_moqaf/featuers/profile/screens/profile_screen.dart';
import 'package:iti_moqaf/featuers/stations/logic/get_all_stations_cubit.dart';
import 'package:iti_moqaf/featuers/stations/screens/StationsScreen.dart';

import '../../community/screens/community.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int index = 0;

  List<Widget> screens = [
    NearStations(),
    BlocProvider(
      create: (context) => getIt<GetAllStationsCubit>()..getAllStations(),
      child: StationsScreen(),
    ),
    BlocProvider(
      create: (context) => getIt<ProfileCubit>()..loadProfile(),
      child: ProfileScreen(),
    ),
    Community(),
  ];

  void changeIndex(int index) {
    this.index = index;
    emit(ChangeHomeIndex(index));
  }
}
