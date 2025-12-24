import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/create_post/data/create_post_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import 'package:iti_moqaf/featuers/community/data/model/post_model.dart';
import 'package:iti_moqaf/featuers/create_post/data/creatr_post_model.dart';

part 'create_post_state.dart';

class CreatePostCubit extends Cubit<CreatePostState> {
  final CreatePostRepo createPostRepo;
  CreatePostCubit(this.createPostRepo) : super(CreatePostInitial());

  final TextEditingController postContent = TextEditingController();
  XFile? pickedImage;
  final ImagePicker _picker = ImagePicker();

  void onContentChanged(String value) {
    emit(CreatePostContentChanged(value.trim().isNotEmpty || pickedImage != null));
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage = image;
      emit(CreatePostImagePicked());
      emit(CreatePostContentChanged(true));
    }
  }

  void removeImage() {
    pickedImage = null;
    emit(CreatePostImageRemoved());
    emit(CreatePostContentChanged(postContent.text.trim().isNotEmpty));
  }

  void clearContent() {
    postContent.clear();
    pickedImage = null;
    emit(CreatePostContentChanged(false));
  }

  Future<void> createPost(CreatePostModel model) async {
    emit(CreatePostLoading());
    try {
      final result = await createPostRepo.createPost(model);
      if (result is ApiSuccess<PostModel>) {
        postContent.clear();
        emit(CreatePostSuccess(result.data));
      } else if (result is ApiError<PostModel>) {
        emit(CreatePostError(result.message));
      }
    } catch (e, stack) {
      print("CreatePostCubit Error: $e");
      print(stack);
      emit(CreatePostError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    postContent.dispose();
    return super.close();
  }
}
