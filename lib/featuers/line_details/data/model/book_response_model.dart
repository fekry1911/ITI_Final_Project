import 'package:json_annotation/json_annotation.dart';

part 'book_response_model.g.dart';

@JsonSerializable()
class SeatBookingResponse {
  final String status;
  final String message;
  final BookingData? data;

  SeatBookingResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory SeatBookingResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatBookingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeatBookingResponseToJson(this);
}

@JsonSerializable()
class BookingData {
  final BookingUser user;
  final BookingVehicle vehicle;
  final String status;
  final DateTime? expiresAt;
  final double price;
  @JsonKey(name: '_id')
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;

  BookingData({
    required this.user,
    required this.vehicle,
    required this.status,
    this.expiresAt,
    required this.price,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}

@JsonSerializable()
class BookingUser {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  BookingUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory BookingUser.fromJson(Map<String, dynamic> json) =>
      _$BookingUserFromJson(json);

  Map<String, dynamic> toJson() => _$BookingUserToJson(this);
}

@JsonSerializable()
class BookingVehicle {
  @JsonKey(name: '_id')
  final String id;
  final String model;
  final String plateNumber;
  final String driverName;
  final int capacity;
  final List<BookingLineData>? lines;
  final BookingStationData currentStation;

  BookingVehicle({
    required this.id,
    required this.model,
    required this.plateNumber,
    required this.driverName,
    required this.capacity,
    this.lines,
    required this.currentStation,
  });

  factory BookingVehicle.fromJson(Map<String, dynamic> json) =>
      _$BookingVehicleFromJson(json);

  Map<String, dynamic> toJson() => _$BookingVehicleToJson(this);
}

@JsonSerializable()
class BookingLineData {
  @JsonKey(name: '_id')
  final String id;
  final BookingStationData fromStation;
  final BookingStationData toStation;
  final double price;

  BookingLineData({
    required this.id,
    required this.fromStation,
    required this.toStation,
    required this.price,
  });

  factory BookingLineData.fromJson(Map<String, dynamic> json) =>
      _$BookingLineDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingLineDataToJson(this);
}

@JsonSerializable()
class BookingStationData {
  @JsonKey(name: '_id')
  final String id;
  final String stationName;

  BookingStationData({
    required this.id,
    required this.stationName,
  });

  factory BookingStationData.fromJson(Map<String, dynamic> json) =>
      _$BookingStationDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingStationDataToJson(this);
}