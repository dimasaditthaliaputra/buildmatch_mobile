import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_message_entity.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();
  @override
  List<Object?> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomLoading extends ChatRoomState {}

class ChatRoomLoaded extends ChatRoomState {
  final List<ChatMessageEntity> messages;
  final bool isSending;
  const ChatRoomLoaded(this.messages, {this.isSending = false});
  @override
  List<Object?> get props => [messages, isSending];

  ChatRoomLoaded copyWith({List<ChatMessageEntity>? messages, bool? isSending}) {
    return ChatRoomLoaded(
      messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }
}

class ChatRoomError extends ChatRoomState {
  final String message;
  const ChatRoomError(this.message);
  @override
  List<Object?> get props => [message];
}
