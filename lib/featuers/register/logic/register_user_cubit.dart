import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iti_moqaf/core/models/user_model.dart';
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

  Future verifyEmail({required String email, required String code}) async {
    emit(VerifyEmailLoading());
    var res = await registerUser.verifyEmail(email, code);
    if (res is ApiSuccess) {
      // res.data is the Dio Response object.
      // res.data.data is the actual response body (Map).
      var response = res.data;
      if (response.data != null &&
          response.data['data'] != null &&
          response.data['data']['accessToken'] != null) {
        await CacheHelper.putString(
          key: "token",
          value: response.data['data']['accessToken'],
        );
        // Parse user data - Assuming structure similar to Login
        try {
          var data = response.data['data'];
          if (data['user'] != null) {
            User userObj = User.fromJson(data['user']);
            await CacheHelper.saveUser(userObj);
          } else {
            // Fallback if data itself is user
            User userObj = User.fromJson(data);
            await CacheHelper.saveUser(userObj);
          }
        } catch (e) {
          print("Error parsing user data in verifyEmail: $e");
        }
      } else {
        print("Warning: Access Token not found in response: ${response.data}");
      }

      emit(VerifyEmailSuccess());
    }
    if (res is ApiError) {
      emit(VerifyEmailError(res.message));
    }
  }
}
