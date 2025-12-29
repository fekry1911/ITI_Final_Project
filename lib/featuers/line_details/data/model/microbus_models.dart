import 'package:json_annotation/json_annotation.dart';

part 'microbus_models.g.dart';

@JsonSerializable()
class MicrobusResponse {
  final int count;
  final List<Microbus> results;

  MicrobusResponse({
    required this.count,
    required this.results,
  });

  factory MicrobusResponse.fromJson(Map<String, dynamic> json) =>
      _$MicrobusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MicrobusResponseToJson(this);

  MicrobusResponse copyWith({
    int? count,
    List<Microbus>? results,
  }) {
    return MicrobusResponse(
      count: count ?? this.count,
      results: results ?? this.results,
    );
  }
}

@JsonSerializable()
class Microbus {
  @JsonKey(name: '_id')
  final String id;
  final String model;
  final String plateNumber;
  final String driverName;
  final int capacity;
  final bool isAirConditioned;
  final String currentStatus;
  final LineData line;
  @JsonKey(name: '__v')
  final int version;
  final List<BookedUser> bookedUsers;
  final int availableSeats;

  Microbus({
    required this.id,
    required this.model,
    required this.plateNumber,
    required this.driverName,
    required this.capacity,
    required this.isAirConditioned,
    required this.currentStatus,
    required this.line,
    required this.version,
    required this.bookedUsers,
    required this.availableSeats,
  });

  factory Microbus.fromJson(Map<String, dynamic> json) =>
      _$MicrobusFromJson(json);

  Map<String, dynamic> toJson() => _$MicrobusToJson(this);

  Microbus copyWith({
    String? id,
    String? model,
    String? plateNumber,
    String? driverName,
    int? capacity,
    bool? isAirConditioned,
    String? currentStatus,
    LineData? line,
    int? version,
    List<BookedUser>? bookedUsers,
    int? availableSeats,
  }) {
    return Microbus(
      id: id ?? this.id,
      model: model ?? this.model,
      plateNumber: plateNumber ?? this.plateNumber,
      driverName: driverName ?? this.driverName,
      capacity: capacity ?? this.capacity,
      isAirConditioned: isAirConditioned ?? this.isAirConditioned,
      currentStatus: currentStatus ?? this.currentStatus,
      line: line ?? this.line,
      version: version ?? this.version,
      bookedUsers: bookedUsers ?? this.bookedUsers,
      availableSeats: availableSeats ?? this.availableSeats,
    );
  }
}

@JsonSerializable()
class LineData {
  @JsonKey(name: '_id')
  final String id;
  final StationData fromStation;
  final StationData toStation;

  LineData({
    required this.id,
    required this.fromStation,
    required this.toStation,
  });

  factory LineData.fromJson(Map<String, dynamic> json) =>
      _$LineDataFromJson(json);

  Map<String, dynamic> toJson() => _$LineDataToJson(this);

  LineData copyWith({
    String? id,
    StationData? fromStation,
    StationData? toStation,
  }) {
    return LineData(
      id: id ?? this.id,
      fromStation: fromStation ?? this.fromStation,
      toStation: toStation ?? this.toStation,
    );
  }
}

@JsonSerializable()
class StationData {
  @JsonKey(name: '_id')
  final String id;
  final String stationName;

  StationData({
    required this.id,
    required this.stationName,
  });

  factory StationData.fromJson(Map<String, dynamic> json) =>
      _$StationDataFromJson(json);

  Map<String, dynamic> toJson() => _$StationDataToJson(this);

  StationData copyWith({
    String? id,
    String? stationName,
  }) {
    return StationData(
      id: id ?? this.id,
      stationName: stationName ?? this.stationName,
    );
  }
}

@JsonSerializable()
class BookedUser {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String bookingStatus;
  final String bookingId;
  final DateTime bookedAt;

  BookedUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.bookingStatus,
    required this.bookingId,
    required this.bookedAt,
  });

  BookedUser copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? bookingStatus,
    String? bookingId,
    DateTime? bookedAt,
  }) {
    return BookedUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      bookingStatus: bookingStatus ?? this.bookingStatus,
      bookingId: bookingId ?? this.bookingId,
      bookedAt: bookedAt ?? this.bookedAt,
    );
  }

  factory BookedUser.fromJson(Map<String, dynamic> json) =>
      _$BookedUserFromJson(json);

  Map<String, dynamic> toJson() => _$BookedUserToJson(this);
}
