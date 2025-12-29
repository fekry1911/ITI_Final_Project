part of 'get_all_chats_cubit.dart';

@immutable
sealed class GetAllChatsState extends Equatable {}

final class GetAllChatsInitial extends GetAllChatsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllChatsLoading extends GetAllChatsState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class GetAllChatsLoaded extends GetAllChatsState {
  final List< ChatData> chatData;

  GetAllChatsLoaded(this.chatData);

  @override
  // TODO: implement props
  List<Object?> get props => [chatData];
}

final class GetAllChatsError extends GetAllChatsState {
  final String error;

  GetAllChatsError(this.error);

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}
