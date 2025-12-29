import 'package:iti_moqaf/core/networking/api_result.dart';
import 'package:iti_moqaf/core/networking/api_service.dart';
import 'package:iti_moqaf/featuers/chat/data/model/chat_models.dart';
import 'package:iti_moqaf/featuers/chat/logic/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/theme/color/colors.dart';
import '../../../../core/networking/socket_service.dart';


class ChatCubit extends Cubit<ChatState> {
  final SocketService _socketService;
  final ApiService _apiService;
  final String userId;
  final String chatPartnerId;
  String? _conversationId;


  ChatCubit(
    this._socketService,
    this._apiService, {
    required this.userId,
    required this.chatPartnerId,
  }) : super(ChatInitial()) {
    initChat();
  }

  Future<void> initChat() async {
    print("ChatCubit: Initializing chat for user $userId with partner $chatPartnerId");
    emit(ChatLoading());

    _socketService.initSocket(userId);
    _setupSocketListeners();

    print("ChatCubit: Fetching conversations...");
    final convResult = await _apiService.getConversations(userId);

    if (convResult is ApiSuccess<List<ConversationModel>>) {
      final conversations = convResult.data;
      final existingConv = conversations.where((c) => c.members?.contains(chatPartnerId) ?? false);

      if (existingConv.isNotEmpty) {
        _conversationId = existingConv.first.id;
        print("ChatCubit: Found existing conversation: $_conversationId");
      } else {
        print("ChatCubit: Creating new conversation...");
        final createResult = await _apiService.createConversation(userId, chatPartnerId);
        if (createResult is ApiSuccess<ConversationModel>) {
          _conversationId = createResult.data.id;
          print("ChatCubit: Created new conversation: $_conversationId");
        } else if (createResult is ApiError<ConversationModel>) {
          print("ChatCubit: Failed to create conversation: ${createResult.message}");
        }
      }
    } else if (convResult is ApiError<List<ConversationModel>>) {
      print("ChatCubit: Failed to fetch conversations: ${convResult.message}");
    }

    if (_conversationId == null) {
      print("ChatCubit: Error: _conversationId is null");
      emit(const ChatError("Could not initialize conversation"));
      return;
    }

    // 3. Load Messages
    print("ChatCubit: Loading messages for ${_conversationId}...");
    final msgResult = await _apiService.getMessages(_conversationId!);
    if (msgResult is ApiSuccess<List<MessageModel>>) {
      print("ChatCubit: Loaded ${msgResult.data.length} messages");
      emit(ChatLoaded(messages: msgResult.data));
    } else if (msgResult is ApiError<List<MessageModel>>) {
      print("ChatCubit: Failed to load messages: ${msgResult.message}");
      emit(ChatError(msgResult.message ?? "Failed to load messages"));
    }
  }

  void _setupSocketListeners() {
    // Listen to messages
    _socketService.onGetMessage((data) {
      print("ChatCubit: Received message from socket: $data");
      if (data == null) return;
      
      final MessageModel message;
      if (data is Map<String, dynamic>) {
        message = MessageModel.fromJson(data);
      } else {
        message = MessageModel(text: data.toString(), senderId: chatPartnerId);
      }

      if (state is ChatLoaded) {
        final currentMessages = List<MessageModel>.from((state as ChatLoaded).messages);
        currentMessages.add(message);
        emit((state as ChatLoaded).copyWith(messages: currentMessages));
      } else {
        emit(ChatLoaded(messages: [message]));
      }
    });
    // ... rest unchanged
  }

  Future<void> sendMessage(String text) async {
    print("ChatCubit: Attempting to send message: $text");
    if (text.isEmpty) return;
    
    if (_conversationId == null) {
      print("ChatCubit: Error: _conversationId is null in sendMessage");
      Fluttertoast.showToast(msg: "المحادثة غير مفعلة", backgroundColor: AppColors.mainColor);
      return;
    }

    // 1. Save to DB via REST
    final result = await _apiService.sendMessage(_conversationId!, userId, text);

    if (result is ApiSuccess<MessageModel>) {
      print("ChatCubit: Message saved via REST");
      final message = result.data;

      // 2. Update UI locally (Success case)
      if (state is ChatLoaded) {
        final currentMessages = List<MessageModel>.from((state as ChatLoaded).messages);
        currentMessages.add(message);
        emit((state as ChatLoaded).copyWith(messages: currentMessages));
      }

      // 3. Emit via Socket for real-time
      print("ChatCubit: Emitting message via Socket...");
      _socketService.sendMessage(receiverId: chatPartnerId, message: message.toJson());
    } else if (result is ApiError<MessageModel>) {
      print("ChatCubit: Failed to save message via REST: ${result.message}");
      Fluttertoast.showToast(msg: "فشل في إرسال الرسالة", backgroundColor: AppColors.mainColor);
    }
  }


  void sendTyping() {
    _socketService.sendTyping(senderId: userId, receiverId: chatPartnerId);
  }

  void sendStopTyping() {
    _socketService.sendStopTyping(senderId: userId, receiverId: chatPartnerId);
  }

  @override
  Future<void> close() {
    _socketService.disconnect();
    return super.close();
  }
}

