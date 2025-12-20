import 'package:json_annotation/json_annotation.dart';

part 'user_login_response.g.dart';

@JsonSerializable()
class UserLoginResponse {
  final String status;
  final LoginData data;

  UserLoginResponse({required this.status, required this.data});

  factory UserLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$UserLoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserLoginResponseToJson(this);
}

@JsonSerializable()
class LoginData {
  final String userId;
  final String accessToken;

  LoginData({required this.userId, required this.accessToken});

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
