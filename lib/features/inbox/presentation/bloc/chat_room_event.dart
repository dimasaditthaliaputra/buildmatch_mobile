import 'package:equatable/equatable.dart';

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
  const SendChatMessageEvent({
    required this.roomId,
    required this.senderId,
    required this.message,
  });
  @override
  List<Object?> get props => [roomId, senderId, message];
}
