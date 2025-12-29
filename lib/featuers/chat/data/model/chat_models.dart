import 'package:json_annotation/json_annotation.dart';

part 'chat_models.g.dart';

@JsonSerializable()
class ChatResponseModel {
  final String? status;
  final List<MessageModel>? data;

  ChatResponseModel({this.status, this.data});

  factory ChatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatResponseModelToJson(this);
}

@JsonSerializable()
class ConversationModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(fromJson: _parseMembers)
  final List<String>? members;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ConversationModel({this.id, this.members, this.createdAt, this.updatedAt});

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'] as String?,
      members: _parseMembers(json['members']),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => _$ConversationModelToJson(this);
}

// Helper function to parse members
List<String>? _parseMembers(dynamic members) {
  if (members is List) {
    return members.map((e) {
      if (e is String) {
        return e;
      } else if (e is Map<String, dynamic>) {
        return (e['_id'] ?? e['id']).toString();
      }
      return '';
    }).where((e) => e.isNotEmpty).toList();
  }
  return null;
}

String? _parseSenderId(dynamic sender) {
  if (sender is String) {
    return sender;
  } else if (sender is Map<String, dynamic>) {
    return sender['_id'] ?? sender['id'];
  }
  return null;
}

@JsonSerializable()
class MessageModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? conversationId;
  @JsonKey(name: 'senderId', fromJson: _parseSenderId)
  final String? senderId;
  final String? text;
  final String? replyTo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel({
    this.id,
    this.conversationId,
    this.senderId,
    this.text,
    this.replyTo,
    this.createdAt,
    this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['_id'] as String?,
      conversationId: json['conversationId'] is Map 
          ? (json['conversationId']['_id'] ?? json['conversationId']['id'])?.toString()
          : json['conversationId'] as String?,
      senderId: _parseSenderId(json['senderId']),
      text: json['text'] as String?,
      replyTo: json['replyTo'] is Map
          ? (json['replyTo']['_id'] ?? json['replyTo']['id'])?.toString()
          : json['replyTo'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
