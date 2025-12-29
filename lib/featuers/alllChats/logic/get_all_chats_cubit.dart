import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/featuers/alllChats/data/all_chats_response.dart';
import 'package:iti_moqaf/featuers/alllChats/data/repo/get_all_chats_repo.dart';
import 'package:meta/meta.dart';

part 'get_all_chats_state.dart';

class GetAllChatsCubit extends Cubit<GetAllChatsState> {
  GetAllChatsRepo getAllChatsRepo;

  GetAllChatsCubit(this.getAllChatsRepo) : super(GetAllChatsInitial());

  Future<void> getAllChats(String id) async {
    emit(GetAllChatsLoading());
    final result = await getAllChatsRepo.getAllChats(id);
    if (result is ApiSuccess<ChatResponse>) {
      final conversations = result.data.data;
      conversations.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
      emit(GetAllChatsLoaded(conversations));
    } else if (result is ApiError<ChatResponse>) {
      emit(GetAllChatsError(result.message));
    }
  }
}
