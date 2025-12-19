part of 'login_cubit.dart';

@immutable
sealed class LoginStates extends Equatable {}

final class LoginInitial extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class LoginLoading extends LoginStates {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class LoginSuccess extends LoginStates {
  final UserLoginRequest user;
  LoginSuccess(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}

final class LoginError extends LoginStates {
  final String error;
  LoginError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
