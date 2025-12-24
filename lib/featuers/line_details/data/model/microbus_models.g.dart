// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'microbus_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MicrobusResponse _$MicrobusResponseFromJson(Map<String, dynamic> json) =>
    MicrobusResponse(
      count: (json['count'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Microbus.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MicrobusResponseToJson(MicrobusResponse instance) =>
    <String, dynamic>{'count': instance.count, 'results': instance.results};

Microbus _$MicrobusFromJson(Map<String, dynamic> json) => Microbus(
  id: json['_id'] as String,
  model: json['model'] as String,
  plateNumber: json['plateNumber'] as String,
  driverName: json['driverName'] as String,
  capacity: (json['capacity'] as num).toInt(),
  isAirConditioned: json['isAirConditioned'] as bool,
  currentStatus: json['currentStatus'] as String,
  line: LineData.fromJson(json['line'] as Map<String, dynamic>),
  version: (json['__v'] as num).toInt(),
  bookedUsers: json['bookedUsers'] as List<dynamic>,
  availableSeats: (json['availableSeats'] as num).toInt(),
);

Map<String, dynamic> _$MicrobusToJson(Microbus instance) => <String, dynamic>{
  '_id': instance.id,
  'model': instance.model,
  'plateNumber': instance.plateNumber,
  'driverName': instance.driverName,
  'capacity': instance.capacity,
  'isAirConditioned': instance.isAirConditioned,
  'currentStatus': instance.currentStatus,
  'line': instance.line,
  '__v': instance.version,
  'bookedUsers': instance.bookedUsers,
  'availableSeats': instance.availableSeats,
};

LineData _$LineDataFromJson(Map<String, dynamic> json) => LineData(
  id: json['_id'] as String,
  fromStation: StationData.fromJson(
    json['fromStation'] as Map<String, dynamic>,
  ),
  toStation: StationData.fromJson(json['toStation'] as Map<String, dynamic>),
);

Map<String, dynamic> _$LineDataToJson(LineData instance) => <String, dynamic>{
  '_id': instance.id,
  'fromStation': instance.fromStation,
  'toStation': instance.toStation,
};

StationData _$StationDataFromJson(Map<String, dynamic> json) => StationData(
  id: json['_id'] as String,
  stationName: json['stationName'] as String,
);

Map<String, dynamic> _$StationDataToJson(StationData instance) =>
    <String, dynamic>{'_id': instance.id, 'stationName': instance.stationName};
