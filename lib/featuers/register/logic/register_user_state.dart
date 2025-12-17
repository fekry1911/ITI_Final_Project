part of 'register_user_cubit.dart';

@immutable
sealed class RegisterUserState extends Equatable {}

final class RegisterUserInitial extends RegisterUserState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class RegisterUserLoading extends RegisterUserState{
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
final class RegisterUserSuccess extends RegisterUserState{
  final User user;
  RegisterUserSuccess(this.user);
  @override
  // TODO: implement props
  List<Object?> get props => [user];
}
final class RegisterUserError extends RegisterUserState{
  final String error;
  RegisterUserError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
