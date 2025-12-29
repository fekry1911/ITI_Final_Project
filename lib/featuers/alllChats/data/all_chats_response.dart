import 'package:json_annotation/json_annotation.dart';

part 'all_chats_response.g.dart';

@JsonSerializable()
class ChatResponse {
  final String status;
  final List<ChatData> data;

  ChatResponse({
    required this.status,
    required this.data,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseToJson(this);
}

@JsonSerializable()
class ChatData {
  @JsonKey(name: '_id')
  final String id;
  final List<Member> members;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;

  ChatData({
    required this.id,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ChatData.fromJson(Map<String, dynamic> json) =>
      _$ChatDataFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDataToJson(this);
}

@JsonSerializable()
class Member {
  @JsonKey(name: '_id')
  final String id;
  final String firstName;
  final String lastName;
  final String avatar;

  Member({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  factory Member.fromJson(Map<String, dynamic> json) =>
      _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}