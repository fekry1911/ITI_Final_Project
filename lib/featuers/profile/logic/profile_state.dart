part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final User? user;
  const ProfileLoaded(this.user);
  @override
  List<Object> get props => [user ?? ''];
}

final class ProfileImagePicked extends ProfileState {
  final File image;
  const ProfileImagePicked(this.image);
  @override
  List<Object> get props => [image];
}

final class ProfileUploading extends ProfileState {}

final class ProfileUploadSuccess extends ProfileState {}

final class ProfileLoggedOut extends ProfileState {}

final class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object> get props => [message];
}
