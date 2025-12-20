// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserLoginResponse _$UserLoginResponseFromJson(Map<String, dynamic> json) =>
    UserLoginResponse(
      status: json['status'] as String,
      data: LoginData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserLoginResponseToJson(UserLoginResponse instance) =>
    <String, dynamic>{'status': instance.status, 'data': instance.data};

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
  userId: json['userId'] as String,
  accessToken: json['accessToken'] as String,
);

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
  'userId': instance.userId,
  'accessToken': instance.accessToken,
};
