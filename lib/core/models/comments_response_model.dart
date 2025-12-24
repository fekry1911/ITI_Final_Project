import 'package:iti_moqaf/core/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comments_response_model.g.dart';

@JsonSerializable()
class CommentModel {
  @JsonKey(name: '_id')
  final String id;
  final User user;
  final String post;
  final String content;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;

  CommentModel({
    required this.id,
    required this.user,
    required this.post,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  CommentModel copyWith({
    String? id,
    User? user,
    String? post,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return CommentModel(
      id: id ?? this.id,
      user: user ?? this.user,
      post: post ?? this.post,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }
}
