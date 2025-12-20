// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: json['_id'] as String?,
  firstName: json['firstName'] as String?,
  lastName: json['lastName'] as String?,
  email: json['email'] as String?,
  avatar: json['avatar'] as String?,
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  '_id': instance.id,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'email': instance.email,
  'avatar': instance.avatar,
};
