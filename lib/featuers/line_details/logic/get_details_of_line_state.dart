part of 'get_details_of_line_cubit.dart';

@immutable
abstract class GetDetailsOfLineState extends Equatable {
  const GetDetailsOfLineState();

  @override
  List<Object?> get props => [];
}

class GetDetailsOfLineInitial extends GetDetailsOfLineState {}

class GetDetailsOfLineLoading extends GetDetailsOfLineState {}

class GetDetailsOfLineError extends GetDetailsOfLineState {
  final String message;

  const GetDetailsOfLineError(this.message);

  @override
  List<Object?> get props => [message];
}

class GetDetailsOfLineSuccess extends GetDetailsOfLineState {
  final List<Microbus> results;
  final int version; // 🔥 مفتاح التحديث اللحظي

  const GetDetailsOfLineSuccess(
      this.results, {
        this.version = 0,
      });

  @override
  List<Object?> get props => [results, version];
}
