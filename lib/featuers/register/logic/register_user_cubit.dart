import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/register/data/repo/register_user.dart';
import 'package:meta/meta.dart';

import '../data/model/user_register_request.dart';

part 'register_user_state.dart';

class RegisterUserCubit extends Cubit<RegisterUserState> {
  RegisterUser registerUser;

  RegisterUserCubit(this.registerUser) : super(RegisterUserInitial());
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterUserLoading());
    UserRegisterRequest user = UserRegisterRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
    );
    var res = await registerUser.registerUser(user);
    if (res is ApiSuccess) {
      await CacheHelper.putBoolean(key: "register", value: true);
      emit(RegisterUserSuccess(user));
    }
    if (res is ApiError) {
      print(res.message);
      emit(RegisterUserError(res.message));
    }
  }
}
