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
  final ChatMessageEntity? replyingTo;
  final ChatMessageEntity? editingMessage;

  const ChatRoomLoaded(
    this.messages, {
    this.isSending = false,
    this.replyingTo,
    this.editingMessage,
  });

  @override
  List<Object?> get props => [messages, isSending, replyingTo, editingMessage];

  ChatRoomLoaded copyWith({
    List<ChatMessageEntity>? messages,
    bool? isSending,
    ChatMessageEntity? replyingTo,
    bool clearReply = false,
    ChatMessageEntity? editingMessage,
    bool clearEditing = false,
  }) {
    return ChatRoomLoaded(
      messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      replyingTo: clearReply ? null : (replyingTo ?? this.replyingTo),
      editingMessage: clearEditing ? null : (editingMessage ?? this.editingMessage),
    );
  }
}

class ChatRoomError extends ChatRoomState {
  final String message;
  const ChatRoomError(this.message);
  @override
  List<Object?> get props => [message];
}
