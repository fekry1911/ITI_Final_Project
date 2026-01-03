import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../const/api_const.dart';

class SocketService {
  late IO.Socket socket;
  final String _baseUrl = apiBaseURL;

  void initSocket(String userId) {
    socket = IO.io(_baseUrl, IO.OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .build());
    socket.connect();
    socket.onConnect((_) {
      print('Conversation Socket Connected: ${socket.id}');
      addUser(userId);
    });
    socket.onDisconnect((_) {
      print('Conversation Socket Disconnected');
    });
    socket.onConnectError((err) {
      print('Socket Error: $err');
    });
  }
  void addUser(String userId) {
    socket.emit('addUser', userId);
  }
  void sendMessage({required String receiverId, required dynamic message}) {
    socket.emit('sendMessage', {
      'receiverId': receiverId,
      'message': message,
    });
  }
  void sendTyping({required String senderId, required String receiverId}) {
    socket.emit('typing', {
      'senderId': senderId,
      'receiverId': receiverId,
    });
  }
  void sendStopTyping({required String senderId, required String receiverId}) {
    socket.emit('stopTyping', {
      'senderId': senderId,
      'receiverId': receiverId,
    });
  }
  void onGetOnlineUsers(Function(List<dynamic>) callback) {
    socket.on('getOnlineUsers', (data) {
      callback(data);
    });
  }
  void onGetMessage(Function(dynamic) callback) {
    socket.on('getMessage', (data) {
      callback(data);
    });
  }
  void onUserTyping(Function(String) callback) {
    socket.on('userTyping', (senderId) {
      callback(senderId);
    });
  }
  void onUserStoppedTyping(Function(String) callback) {
    socket.on('userStoppedTyping', (senderId) {
      callback(senderId);
    });
  }
  void disconnect() {
    socket.disconnect();
  }
}