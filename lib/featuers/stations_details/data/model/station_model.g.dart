// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationModel _$StationModelFromJson(Map<String, dynamic> json) => StationModel(
  data: StationData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$StationModelToJson(StationModel instance) =>
    <String, dynamic>{'data': instance.data};

StationData _$StationDataFromJson(Map<String, dynamic> json) => StationData(
  location: Location.fromJson(json['location'] as Map<String, dynamic>),
  id: json['_id'] as String,
  stationName: json['stationName'] as String,
  lines: (json['lines'] as List<dynamic>)
      .map((e) => LineModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: json['status'] as String,
  v: (json['__v'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$StationDataToJson(StationData instance) =>
    <String, dynamic>{
      'location': instance.location,
      '_id': instance.id,
      'stationName': instance.stationName,
      'lines': instance.lines,
      'status': instance.status,
      '__v': instance.v,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  type: json['type'] as String,
  coordinates: Location._toDoubleList(json['coordinates'] as List),
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'type': instance.type,
  'coordinates': instance.coordinates,
};

LineModel _$LineModelFromJson(Map<String, dynamic> json) => LineModel(
  id: json['_id'] as String,
  fromStation: StationRef.fromJson(json['fromStation'] as Map<String, dynamic>),
  toStation: json['toStation'] == null
      ? null
      : StationRef.fromJson(json['toStation'] as Map<String, dynamic>),
  price: json['price'] as num,
  distance: json['distance'] as num?,
);

Map<String, dynamic> _$LineModelToJson(LineModel instance) => <String, dynamic>{
  '_id': instance.id,
  'fromStation': instance.fromStation,
  'toStation': instance.toStation,
  'price': instance.price,
  'distance': instance.distance,
};

StationRef _$StationRefFromJson(Map<String, dynamic> json) => StationRef(
  id: json['_id'] as String,
  stationName: json['stationName'] as String?,
);

Map<String, dynamic> _$StationRefToJson(StationRef instance) =>
    <String, dynamic>{'_id': instance.id, 'stationName': instance.stationName};
