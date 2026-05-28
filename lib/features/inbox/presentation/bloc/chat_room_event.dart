import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message_entity.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatMessagesEvent extends ChatRoomEvent {
  final String roomId;
  final String currentUserId;
  const LoadChatMessagesEvent({required this.roomId, required this.currentUserId});
  @override
  List<Object?> get props => [roomId, currentUserId];
}

class SendChatMessageEvent extends ChatRoomEvent {
  final String roomId;
  final String senderId;
  final String message;
  final ChatMessageEntity? replyTo;
  final String? attachmentUrl;
  final String? attachmentType;
  final String? attachmentName;

  const SendChatMessageEvent({
    required this.roomId,
    required this.senderId,
    required this.message,
    this.replyTo,
    this.attachmentUrl,
    this.attachmentType,
    this.attachmentName,
  });
  @override
  List<Object?> get props => [roomId, senderId, message, replyTo];
}

class EditChatMessageEvent extends ChatRoomEvent {
  final String roomId;
  final String messageId;
  final String newMessage;
  const EditChatMessageEvent({
    required this.roomId,
    required this.messageId,
    required this.newMessage,
  });
  @override
  List<Object?> get props => [roomId, messageId, newMessage];
}

class SetReplyMessageEvent extends ChatRoomEvent {
  final ChatMessageEntity message;
  const SetReplyMessageEvent(this.message);
  @override
  List<Object?> get props => [message];
}

class ClearReplyMessageEvent extends ChatRoomEvent {}

class SetEditingMessageEvent extends ChatRoomEvent {
  final ChatMessageEntity message;
  const SetEditingMessageEvent(this.message);
  @override
  List<Object?> get props => [message];
}

class ClearEditingMessageEvent extends ChatRoomEvent {}
