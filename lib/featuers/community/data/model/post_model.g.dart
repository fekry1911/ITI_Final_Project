// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['_id'] as String,
  user: User.fromJson(json['user'] as Map<String, dynamic>),
  category: json['category'] as String,
  content: json['content'] as String,
  media: json['media'] as String?,
  mediaType: json['mediaType'] as String,
  likesCount: (json['likesCount'] as num).toInt(),
  commentsCount: (json['commentsCount'] as num).toInt(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
  version: (json['__v'] as num).toInt(),
  isLiked: json['isLiked'] as bool,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  '_id': instance.id,
  'user': instance.user,
  'category': instance.category,
  'content': instance.content,
  'media': instance.media,
  'mediaType': instance.mediaType,
  'likesCount': instance.likesCount,
  'commentsCount': instance.commentsCount,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
  '__v': instance.version,
  'isLiked': instance.isLiked,
};
