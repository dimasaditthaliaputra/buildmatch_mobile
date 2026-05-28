import '../entities/consultation_room_entity.dart';
import '../entities/chat_message_entity.dart';

abstract class InboxRepository {
  Future<List<ConsultationRoomEntity>> getConsultationRooms(String currentUserId);
  Future<List<ChatMessageEntity>> getChatMessages(String roomId);
  Future<ChatMessageEntity> sendMessage({
    required String roomId,
    required String senderId,
    required String message,
    String? replyToId,
    String? replyToMessage,
    String? replyToSenderId,
    String? attachmentUrl,
    String? attachmentType,
    String? attachmentName,
  });
  Future<ChatMessageEntity> editMessage({
    required String roomId,
    required String messageId,
    required String newMessage,
  });
  Future<void> markMessagesAsRead(String roomId, String currentUserId);
}
