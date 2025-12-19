import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_moqaf/core/helpers/cach_helper.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/login/data/models/user_login_request.dart';
import 'package:iti_moqaf/featuers/login/data/repo/login_request_repo.dart';

part 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginRequestRepo loginUser;

  LoginCubit(this.loginUser) : super(LoginInitial());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Future login({required String email, required String password}) async {
    emit(LoginLoading());
    UserLoginRequest user = UserLoginRequest(email: email, password: password);
    var res = await loginUser.loginUser(user);
    if (res is ApiSuccess) {
      await CacheHelper.putBoolean(key: "token", value: true);
      emit(LoginSuccess(user));
    }
    if (res is ApiError) {
      emit(LoginError(res.message));
    }
  }
}
