// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'near_stations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationLocationModel _$StationLocationModelFromJson(
  Map<String, dynamic> json,
) => StationLocationModel(
  type: json['type'] as String,
  coordinates: (json['coordinates'] as List<dynamic>)
      .map((e) => (e as num).toDouble())
      .toList(),
);

Map<String, dynamic> _$StationLocationModelToJson(
  StationLocationModel instance,
) => <String, dynamic>{
  'type': instance.type,
  'coordinates': instance.coordinates,
};

NearStationModel _$NearStationModelFromJson(Map<String, dynamic> json) =>
    NearStationModel(
      id: json['_id'] as String,
      stationName: json['stationName'] as String,
      lines: json['lines'] as List<dynamic>,
      status: json['status'] as String,
      location: StationLocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$NearStationModelToJson(NearStationModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'stationName': instance.stationName,
      'lines': instance.lines,
      'status': instance.status,
      'location': instance.location,
    };

StationsResponseModel _$StationsResponseModelFromJson(
  Map<String, dynamic> json,
) => StationsResponseModel(
  count: (json['count'] as num).toInt(),
  data: (json['data'] as List<dynamic>)
      .map((e) => NearStationModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$StationsResponseModelToJson(
  StationsResponseModel instance,
) => <String, dynamic>{'count': instance.count, 'data': instance.data};
