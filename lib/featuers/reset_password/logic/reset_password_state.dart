part of 'reset_password_cubit.dart';

@immutable
sealed class ResetPasswordState extends Equatable {}

final class ResetPasswordInitial extends ResetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

final class ResetPasswordLoading extends ResetPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class ResetPasswordSuccess extends ResetPasswordState {
  final String data;
  ResetPasswordSuccess({required this.data});
  @override
  // TODO: implement props
  List<Object?> get props => [data];
}

final class ResetPasswordError extends ResetPasswordState{
  final String error;
  ResetPasswordError(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
