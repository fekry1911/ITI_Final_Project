import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/models/user_model.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';

import 'package:iti_moqaf/featuers/profile/data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo;

  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  User? currentUser;

  void loadProfile(userId) async {
    emit(ProfileLoading());
      final result = await profileRepo.getUserDetails(userId);
      if (result is ApiSuccess<User>) {
        currentUser = result.data;
        print("Fetched User: ${currentUser?.firstName}");
        emit(ProfileLoaded(result.data));
      } else if (result is ApiError<User>) {
        print("Profile Error: ${result.message}");
        emit(ProfileError(result.message));

    }
  }

  Future<void> logout() async {
    await CacheHelper.clearUser();
    await CacheHelper.removeString(key: 'token');
    emit(ProfileLoggedOut());
  }
}
