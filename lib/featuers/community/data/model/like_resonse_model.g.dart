// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_resonse_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikeResponseModel _$LikeResponseModelFromJson(Map<String, dynamic> json) =>
    LikeResponseModel(
      message: json['message'] as String,
      likesCount: (json['likesCount'] as num).toInt(),
    );

Map<String, dynamic> _$LikeResponseModelToJson(LikeResponseModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'likesCount': instance.likesCount,
    };
