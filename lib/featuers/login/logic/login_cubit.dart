import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/cach_helper.dart';
import '../../../core/networking/api_result.dart';
import '../data/models/user_login_request.dart';
import '../data/models/user_login_response.dart';
import '../data/repo/login_request_repo.dart';
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
    final res = await loginUser.loginUser(user);
    if (res is ApiSuccess<UserLoginResponse>) {
      final responseBody = res.data;
      if (responseBody.status == 'success') {
        await CacheHelper.putString(
          key: "token",
          value: responseBody.data.accessToken,
        );
        await CacheHelper.putString(
          key: "userId",
          value: responseBody.data.userId,
        );
        emit(LoginSuccess(user));
      } else {
        emit(LoginError("Login failed status: ${responseBody.status}"));
      }
    } else if (res is ApiError<UserLoginResponse>) {
      emit(LoginError(res.message));
    }
  }
}
