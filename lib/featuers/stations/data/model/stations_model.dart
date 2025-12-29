import 'package:json_annotation/json_annotation.dart';

part 'stations_model.g.dart';

@JsonSerializable()
class SimpleStationData {
  @JsonKey(name: '_id')
  final String? id;
  final String stationName;
  final List<dynamic> lines;
  final String status;
  final Location? location;

  SimpleStationData({
    this.id,
    required this.stationName,
    required this.lines,
    required this.status,
    this.location,
  });

  factory SimpleStationData.fromJson(Map<String, dynamic> json) =>
      _$SimpleStationDataFromJson(json);

  Map<String, dynamic> toJson() => _$SimpleStationDataToJson(this);
}

@JsonSerializable()
class SimpleStationsResponse {
  final int count;
  final int lastPage;
  final int page;
  final int limit;
  final List<SimpleStationData> data;

  SimpleStationsResponse({
    required this.count,
    required this.page,
    required this.limit,
    required this.data,
    required this.lastPage,
  });

  factory SimpleStationsResponse.fromJson(Map<String, dynamic> json) {
    return SimpleStationsResponse(
      lastPage: int.tryParse(json['lastPage'].toString()) ?? 0,
      count: int.tryParse(json['count'].toString()) ?? 0,
      page: int.tryParse(json['page'].toString()) ?? 0,
      limit: int.tryParse(json['limit'].toString()) ?? 0,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SimpleStationData.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => _$SimpleStationsResponseToJson(this);
}

@JsonSerializable()
class Location {
  final String type;
  final List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}

