import '../entities/consultation_room_entity.dart';
import '../entities/chat_message_entity.dart';

abstract class InboxRepository {
  Future<List<ConsultationRoomEntity>> getConsultationRooms(String currentUserId);
  Future<List<ChatMessageEntity>> getChatMessages(String roomId);
  Future<ChatMessageEntity> sendMessage({
    required String roomId,
    required String senderId,
    required String message,
  });
  Future<void> markMessagesAsRead(String roomId, String currentUserId);
}
