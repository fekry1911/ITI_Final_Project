import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iti_moqaf/featuers/near_stations/screens/screen.dart';
import 'package:iti_moqaf/featuers/profile/screens/profile.dart';
import 'package:iti_moqaf/featuers/stations/screens/StationsScreen.dart';
import 'package:meta/meta.dart';

import '../../community/screens/community.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int index=0;

  List<Widget> screens=[
    NearStations(),
    StationsScreen(),
    Profile(),
    Community()
  ];

  void setIndex(index){
    this.index=index;
    emit(ChangeHomeIndex(index));
  }
}
