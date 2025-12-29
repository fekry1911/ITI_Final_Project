// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_chats_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatResponse _$ChatResponseFromJson(Map<String, dynamic> json) => ChatResponse(
  status: json['status'] as String,
  data: (json['data'] as List<dynamic>)
      .map((e) => ChatData.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ChatResponseToJson(ChatResponse instance) =>
    <String, dynamic>{'status': instance.status, 'data': instance.data};

ChatData _$ChatDataFromJson(Map<String, dynamic> json) => ChatData(
  id: json['_id'] as String,
  members: (json['members'] as List<dynamic>)
      .map((e) => Member.fromJson(e as Map<String, dynamic>))
      .toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num).toInt(),
);

Map<String, dynamic> _$ChatDataToJson(ChatData instance) => <String, dynamic>{
  '_id': instance.id,
  'members': instance.members,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  '__v': instance.version,
};

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
  id: json['_id'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  avatar: json['avatar'] as String,
);

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
  '_id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatar': instance.avatar,
};
