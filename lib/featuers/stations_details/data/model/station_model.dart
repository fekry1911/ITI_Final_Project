import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

@JsonSerializable()
class StationModel {
  /// data field
  final Data data;

  const StationModel({
    required this.data,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) => _$StationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}

@JsonSerializable()
class Location {
  /// type field
  final String type;
  /// coordinates field
  final List<double> coordinates;

  const Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

@JsonSerializable()
class Data {
  /// location field
  final Location location;
  /// _id field
  ///
  @JsonKey(name: '_id')
  final String id;
  /// stationName field
  final String stationName;
  /// lines field
  final List<dynamic> lines;
  /// status field
  final String status;
  /// __v field
  @JsonKey(name: '__v')
  final int V;
  /// createdAt field
  final DateTime createdAt;
  /// updatedAt field
  final DateTime updatedAt;

  const Data({
    required this.location,
    required this.id,
    required this.stationName,
    required this.lines,
    required this.status,
    required this.V,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}