import 'dart:io';
import 'package:dio/dio.dart';

class CreatePostModel {
  final String content;
  final String category;
  final File? media;

  CreatePostModel({
    required this.content,
    required this.category,
    this.media,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'content': content,
      'category': category,
      if (media != null)
        'media': await MultipartFile.fromFile(
          media!.path,
          filename: media!.path.split('/').last,
        ),
    });
  }
}
