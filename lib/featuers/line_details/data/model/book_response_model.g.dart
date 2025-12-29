// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatBookingResponse _$SeatBookingResponseFromJson(Map<String, dynamic> json) =>
    SeatBookingResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : BookingData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SeatBookingResponseToJson(
  SeatBookingResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'data': instance.data,
};

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
  user: BookingUser.fromJson(json['user'] as Map<String, dynamic>),
  vehicle: BookingVehicle.fromJson(json['vehicle'] as Map<String, dynamic>),
  status: json['status'] as String,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  price: (json['price'] as num).toDouble(),
  id: json['_id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
    <String, dynamic>{
      'user': instance.user,
      'vehicle': instance.vehicle,
      'status': instance.status,
      'expiresAt': instance.expiresAt?.toIso8601String(),
      'price': instance.price,
      '_id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      '__v': instance.version,
    };

BookingUser _$BookingUserFromJson(Map<String, dynamic> json) => BookingUser(
  id: json['_id'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$BookingUserToJson(BookingUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
    };

BookingVehicle _$BookingVehicleFromJson(Map<String, dynamic> json) =>
    BookingVehicle(
      id: json['_id'] as String,
      model: json['model'] as String,
      plateNumber: json['plateNumber'] as String,
      driverName: json['driverName'] as String,
    );

Map<String, dynamic> _$BookingVehicleToJson(BookingVehicle instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'model': instance.model,
      'plateNumber': instance.plateNumber,
      'driverName': instance.driverName,
    };
