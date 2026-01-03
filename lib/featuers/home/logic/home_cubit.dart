import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../community/screens/community.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int index = 0;


  void changeIndex(int index) {
    this.index = index;
    emit(ChangeHomeIndex(index));
  }
}
