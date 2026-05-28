import '../../domain/entities/consultation_room_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/inbox_repository.dart';
import '../datasources/inbox_local_data_source.dart';

class InboxRepositoryImpl implements InboxRepository {
  final InboxLocalDataSource localDataSource;

  InboxRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ConsultationRoomEntity>> getConsultationRooms(
      String currentUserId) async {
    return await localDataSource.getConsultationRooms(currentUserId);
  }

  @override
  Future<List<ChatMessageEntity>> getChatMessages(String roomId) async {
    return await localDataSource.getChatMessages(roomId);
  }

  @override
  Future<ChatMessageEntity> sendMessage({
    required String roomId,
    required String senderId,
    required String message,
  }) async {
    return await localDataSource.sendMessage(
      roomId: roomId,
      senderId: senderId,
      message: message,
    );
  }

  @override
  Future<void> markMessagesAsRead(String roomId, String currentUserId) async {
    return await localDataSource.markMessagesAsRead(roomId, currentUserId);
  }
}
