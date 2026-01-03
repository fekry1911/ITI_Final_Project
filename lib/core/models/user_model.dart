import 'package:json_annotation/json_annotation.dart';
import '../const/api_const.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? avatar;

  const User({this.id, this.firstName, this.lastName, this.email, this.avatar});

  String get avatarUrl {
    if (avatar != null && avatar!.isNotEmpty) {
      if (avatar!.startsWith('http')) return avatar!;
      // Replaces backslashes with forward slashes to ensure valid URL structure
      final cleanAvatarPath = avatar!.replaceAll('\\', '/');
      return '$apiBaseURL/uploads/$cleanAvatarPath';
    }
    return '';
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
