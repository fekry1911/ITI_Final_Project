part of 'home_cubit.dart';

@immutable
sealed class HomeState extends Equatable {}

final class HomeInitial extends HomeState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
final class ChangeHomeIndex extends HomeState {
  final int index;
  ChangeHomeIndex(this.index);

  @override
  // TODO: implement props
  List<Object?> get props => [index];
}
