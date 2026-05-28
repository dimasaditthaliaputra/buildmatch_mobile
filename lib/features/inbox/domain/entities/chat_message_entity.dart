import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String id;
  final String roomId;
  final String senderId;
  final String message;
  final Map<String, dynamic>? metadata;
  final bool isRead;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Reply
  final String? replyToId;
  final String? replyToMessage;
  final String? replyToSenderId;

  // Edit
  final bool isEdited;
  final DateTime? editedAt;

  // Attachment
  final String? attachmentUrl;
  final String? attachmentType; // 'image' | 'document' | 'video'
  final String? attachmentName;

  const ChatMessageEntity({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.message,
    this.metadata,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
    this.replyToId,
    this.replyToMessage,
    this.replyToSenderId,
    this.isEdited = false,
    this.editedAt,
    this.attachmentUrl,
    this.attachmentType,
    this.attachmentName,
  });

  bool isMine(String currentUserId) => senderId == currentUserId;

  bool get canEdit {
    final diff = DateTime.now().difference(createdAt);
    return diff.inMinutes <= 30;
  }

  bool get hasAttachment => attachmentUrl != null;
  bool get hasReply => replyToId != null;

  ChatMessageEntity copyWith({
    String? message,
    bool? isEdited,
    DateTime? editedAt,
    bool? isRead,
    String? replyToId,
    String? replyToMessage,
    String? replyToSenderId,
    String? attachmentUrl,
    String? attachmentType,
    String? attachmentName,
  }) {
    return ChatMessageEntity(
      id: id,
      roomId: roomId,
      senderId: senderId,
      message: message ?? this.message,
      metadata: metadata,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      replyToId: replyToId ?? this.replyToId,
      replyToMessage: replyToMessage ?? this.replyToMessage,
      replyToSenderId: replyToSenderId ?? this.replyToSenderId,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachmentType: attachmentType ?? this.attachmentType,
      attachmentName: attachmentName ?? this.attachmentName,
    );
  }

  @override
  List<Object?> get props => [
        id, roomId, senderId, message, metadata, isRead,
        createdAt, updatedAt, replyToId, replyToMessage, replyToSenderId,
        isEdited, editedAt, attachmentUrl, attachmentType, attachmentName,
      ];
}
