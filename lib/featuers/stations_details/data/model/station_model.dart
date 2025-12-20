import 'package:json_annotation/json_annotation.dart';

part 'station_model.g.dart';

/// =======================
/// Station Root Model
/// =======================
@JsonSerializable()
class StationModel {
  final StationData data;

  const StationModel({
    required this.data,
  });

  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationModelToJson(this);
}

/// =======================
/// Station Data
/// =======================
@JsonSerializable()
class StationData {
  final Location location;

  @JsonKey(name: '_id')
  final String id;

  final String stationName;

  final List<LineModel> lines;

  final String status;

  @JsonKey(name: '__v')
  final int v;

  final DateTime createdAt;
  final DateTime updatedAt;

  const StationData({
    required this.location,
    required this.id,
    required this.stationName,
    required this.lines,
    required this.status,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StationData.fromJson(Map<String, dynamic> json) =>
      _$StationDataFromJson(json);

  Map<String, dynamic> toJson() => _$StationDataToJson(this);
}

/// =======================
/// Location Model
/// =======================
@JsonSerializable()
class Location {
  final String type;

  @JsonKey(fromJson: _toDoubleList)
  final List<double> coordinates;

  const Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  static List<double> _toDoubleList(List list) =>
      list.map((e) => (e as num).toDouble()).toList();
}

/// =======================
/// Line Model
/// =======================
@JsonSerializable()
class LineModel {
  @JsonKey(name: '_id')
  final String id;

  final String fromStation;
  final String toStation;

  final num price;
  final num? distance;

  const LineModel({
    required this.id,
    required this.fromStation,
    required this.toStation,
    required this.price,
    this.distance,
  });

  factory LineModel.fromJson(Map<String, dynamic> json) =>
      _$LineModelFromJson(json);

  Map<String, dynamic> toJson() => _$LineModelToJson(this);
}
