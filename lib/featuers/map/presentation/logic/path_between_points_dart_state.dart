part of 'path_between_points_dart_cubit.dart';

@immutable
class PathBetweenPointsDartState {
  final String? message;
  final bool isLoading;
  final Feature? data;
  final TravelMode mode;


  PathBetweenPointsDartState({
    required this.isLoading,
    required this.data,
    required this.message,
    required this.mode,
  });

  factory PathBetweenPointsDartState.initial() {
    return PathBetweenPointsDartState(
      isLoading: false,
      data: null,
      message: null,
      mode: TravelMode.car,
    );
  }

  PathBetweenPointsDartState copyWith({
    String? message,
    bool? isLoading,
    Feature? data,
    TravelMode? mode,
  }) {
    return PathBetweenPointsDartState(
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      mode: mode ?? this.mode,

    );
  }
}
