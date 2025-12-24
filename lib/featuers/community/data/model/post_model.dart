import 'package:json_annotation/json_annotation.dart';

import 'package:iti_moqaf/core/models/user_model.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  @JsonKey(name: '_id')
  final String id;
  final User user;
  final String category;
  final String content;
  final String? media;
  final String mediaType;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  @JsonKey(name: '__v')
  final int version;
  final bool isLiked;

  PostModel({
    required this.id,
    required this.user,
    required this.category,
    required this.content,
    this.media,
    required this.mediaType,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.isLiked,
  });

  PostModel copyWith({
    bool? isLiked,
    int? likesCount,
    int? commentsCount,
  }) {
    return PostModel(
      id: id,
      user: user,
      category: category,
      content: content,
      media: media,
      mediaType: mediaType,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt,
      updatedAt: updatedAt,
      version: version,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}

