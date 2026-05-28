import '../../domain/entities/chat_message_entity.dart';

class ChatMessageModel extends ChatMessageEntity {
  const ChatMessageModel({
    required super.id,
    required super.roomId,
    required super.senderId,
    required super.message,
    super.metadata,
    required super.isRead,
    required super.createdAt,
    required super.updatedAt,
    super.replyToId,
    super.replyToMessage,
    super.replyToSenderId,
    super.isEdited,
    super.editedAt,
    super.attachmentUrl,
    super.attachmentType,
    super.attachmentName,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      id: json['id'] ?? '',
      roomId: json['room_id'] ?? '',
      senderId: json['sender_id'] ?? '',
      message: json['message'] ?? '',
      metadata: json['metadata'] as Map<String, dynamic>?,
      isRead: json['is_read'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      replyToId: json['reply_to_id'],
      replyToMessage: json['reply_to_message'],
      replyToSenderId: json['reply_to_sender_id'],
      isEdited: json['is_edited'] ?? false,
      editedAt: json['edited_at'] != null ? DateTime.parse(json['edited_at']) : null,
      attachmentUrl: json['attachment_url'],
      attachmentType: json['attachment_type'],
      attachmentName: json['attachment_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'room_id': roomId,
      'sender_id': senderId,
      'message': message,
      'metadata': metadata ?? {},
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'reply_to_id': replyToId,
      'reply_to_message': replyToMessage,
      'reply_to_sender_id': replyToSenderId,
      'is_edited': isEdited,
      'edited_at': editedAt?.toIso8601String(),
      'attachment_url': attachmentUrl,
      'attachment_type': attachmentType,
      'attachment_name': attachmentName,
    };
  }

  factory ChatMessageModel.fromEntity(ChatMessageEntity entity) {
    return ChatMessageModel(
      id: entity.id,
      roomId: entity.roomId,
      senderId: entity.senderId,
      message: entity.message,
      metadata: entity.metadata,
      isRead: entity.isRead,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      replyToId: entity.replyToId,
      replyToMessage: entity.replyToMessage,
      replyToSenderId: entity.replyToSenderId,
      isEdited: entity.isEdited,
      editedAt: entity.editedAt,
      attachmentUrl: entity.attachmentUrl,
      attachmentType: entity.attachmentType,
      attachmentName: entity.attachmentName,
    );
  }
}
