// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleStationData _$SimpleStationDataFromJson(Map<String, dynamic> json) =>
    SimpleStationData(
      id: json['_id'] as String?,
      stationName: json['stationName'] as String,
      lines: json['lines'] as List<dynamic>,
      status: json['status'] as String,
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SimpleStationDataToJson(SimpleStationData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'stationName': instance.stationName,
      'lines': instance.lines,
      'status': instance.status,
      'location': instance.location,
    };

SimpleStationsResponse _$SimpleStationsResponseFromJson(
  Map<String, dynamic> json,
) => SimpleStationsResponse(
  count: (json['count'] as num).toInt(),
  page: (json['page'] as num).toInt(),
  limit: (json['limit'] as num).toInt(),
  data: (json['data'] as List<dynamic>)
      .map((e) => SimpleStationData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$SimpleStationsResponseToJson(
  SimpleStationsResponse instance,
) => <String, dynamic>{
  'count': instance.count,
  'page': instance.page,
  'limit': instance.limit,
  'data': instance.data,
};

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
