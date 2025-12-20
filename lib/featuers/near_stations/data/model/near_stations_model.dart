import 'package:json_annotation/json_annotation.dart';

part 'near_stations_model.g.dart';

@JsonSerializable()
class StationLocationModel {
  final String type;
  final List<double> coordinates;

  StationLocationModel({
    required this.type,
    required this.coordinates,
  });

  factory StationLocationModel.fromJson(Map<String, dynamic> json) =>
      _$StationLocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$StationLocationModelToJson(this);
}

@JsonSerializable()
class NearStationModel {
  @JsonKey(name: '_id')
  final String id;
  final String stationName;
  final List<dynamic> lines;
  final String status;
  final StationLocationModel location;

  NearStationModel({
    required this.id,
    required this.stationName,
    required this.lines,
    required this.status,
    required this.location,
  });

  factory NearStationModel.fromJson(Map<String, dynamic> json) =>
      _$NearStationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NearStationModelToJson(this);
}

@JsonSerializable()
class StationsResponseModel {
  final int count;
  final List<NearStationModel> data;

  StationsResponseModel({
    required this.count,
    required this.data,
  });

  factory StationsResponseModel.fromJson(Map<String, dynamic> json) {
    return StationsResponseModel(
      count: int.tryParse(json['count'].toString()) ?? 0,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => NearStationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$StationsResponseModelToJson(this);
}
