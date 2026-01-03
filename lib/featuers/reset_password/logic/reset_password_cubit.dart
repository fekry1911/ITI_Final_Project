import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../core/networking/api_result.dart';
import '../data/repo/reset_password.dart';
import '../data/repo/send_code_repo.dart';
import '../data/repo/verify_code.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  SendCodeOfVerificationRepo sendCodeOfVerificationRepo;
  VerifyCodeOfVerification verifyCodeOfVerification;
  ResetPasswordRepo resetPasswordRepo;

  ResetPasswordCubit(
    this.sendCodeOfVerificationRepo,
    this.verifyCodeOfVerification,
    this.resetPasswordRepo,
  ) : super(ResetPasswordInitial());

  Future<void> sendCode(String email) async {
    emit(ResetPasswordLoading());
    var result = await sendCodeOfVerificationRepo.sendVerificationCode(
      email: email,
    );
    if (result is ApiSuccess<String>) {
      emit(ResetPasswordSuccess(data: result.data));
    } else if (result is ApiError<String>) {
      emit(ResetPasswordError(result.message));
    }
  }

  Future<void> verifyCode(String code) async {
    emit(ResetPasswordLoading());
    var result = await verifyCodeOfVerification.verifyOfVerificationCode(
      code: code,
    );
    if (result is ApiSuccess<String>) {
      emit(ResetPasswordSuccess(data: result.data));
    } else if (result is ApiError<String>) {
      emit(ResetPasswordError(result.message));
    }
  }

  Future<void> resetPassword(
    String newPassword,
    String confirmPassword,
    String token,
  ) async {
    emit(ResetPasswordLoading());
    var result = await resetPasswordRepo.handleResetPassword(
      newPassword: newPassword,
      confirmPassword: confirmPassword,
      token: token,
    );
    if (result is ApiSuccess<String>) {
      emit(ResetPasswordSuccess(data: result.data));
    } else if (result is ApiError<String>) {
      emit(ResetPasswordError(result.message));
    }
  }
}
