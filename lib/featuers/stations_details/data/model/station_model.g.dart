// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) =>
    StationModel(data: Data.fromJson(json['data'] as Map<String, dynamic>));

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{'data': instance.data};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  type: json['type'] as String,
  coordinates: (json['coordinates'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'type': instance.type,
  'coordinates': instance.coordinates,
};

Data _$DataFromJson(Map<String, dynamic> json) => Data(
  location: Location.fromJson(json['location'] as Map<String, dynamic>),
  id: json['_id'] as String,
  stationName: json['stationName'] as String,
  lines: json['lines'] as List<dynamic>,
  status: json['status'] as String,
  V: (json['__v'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
  'location': instance.location,
  '_id': instance.id,
  'stationName': instance.stationName,
  'lines': instance.lines,
  'status': instance.status,
  '__v': instance.V,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
