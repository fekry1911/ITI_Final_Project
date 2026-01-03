import 'package:equatable/equatable.dart';
import '../data/model/chat_models.dart';


abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object?> get props => [];
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<MessageModel> messages;
  final bool isTyping;

  const ChatLoaded({this.messages = const [], this.isTyping = false});

  ChatLoaded copyWith({List<MessageModel>? messages, bool? isTyping}) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      isTyping: isTyping ?? this.isTyping,
    );
  }

  @override
  List<Object?> get props => [messages, isTyping];
}


class ChatError extends ChatState {
  final String message;

  const ChatError(this.message);

  @override
  List<Object?> get props => [message];
}
