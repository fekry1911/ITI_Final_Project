import 'package:json_annotation/json_annotation.dart';

part 'user_register_request.g.dart';

@JsonSerializable()
class UserRegisterRequest {
  /// email field
  final String email;

  /// password field
  final String password;

  /// firstName field
  final String firstName;

  /// lastName field
  final String lastName;

  const UserRegisterRequest({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  factory UserRegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRegisterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRegisterRequestToJson(this);
}
