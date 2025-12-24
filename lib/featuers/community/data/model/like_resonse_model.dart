import 'package:json_annotation/json_annotation.dart';

part 'like_resonse_model.g.dart';

@JsonSerializable()
class LikeResponseModel {
  final String message;
  final int likesCount;

  LikeResponseModel({
    required this.message,
    required this.likesCount,
  });

  factory LikeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LikeResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LikeResponseModelToJson(this);
}
