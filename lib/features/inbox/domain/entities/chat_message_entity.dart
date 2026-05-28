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

  const ChatMessageEntity({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.message,
    this.metadata,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  bool isMine(String currentUserId) => senderId == currentUserId;

  @override
  List<Object?> get props => [
        id, roomId, senderId, message, metadata, isRead, createdAt, updatedAt,
      ];
}
