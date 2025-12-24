part of 'get_details_of_line_cubit.dart';

@immutable
sealed class GetDetailsOfLineState extends Equatable {}

final class GetDetailsOfLineInitial extends GetDetailsOfLineState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetDetailsOfLineSuccess extends GetDetailsOfLineState {
  final List<Microbus> results;

  GetDetailsOfLineSuccess(this.results);

  @override
  // TODO: implement props
  List<Object?> get props => [results];
}

final class GetDetailsOfLineLoading extends GetDetailsOfLineState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetDetailsOfLineError extends GetDetailsOfLineState {
  final String message;

  GetDetailsOfLineError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
