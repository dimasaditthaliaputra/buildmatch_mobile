import '../../domain/entities/consultation_room_entity.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/repositories/inbox_repository.dart';
import '../datasources/inbox_local_data_source.dart';

class InboxRepositoryImpl implements InboxRepository {
  final InboxLocalDataSource localDataSource;
  InboxRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ConsultationRoomEntity>> getConsultationRooms(String currentUserId) =>
      localDataSource.getConsultationRooms(currentUserId);

  @override
  Future<List<ChatMessageEntity>> getChatMessages(String roomId) =>
      localDataSource.getChatMessages(roomId);

  @override
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
  }) =>
      localDataSource.sendMessage(
        roomId: roomId,
        senderId: senderId,
        message: message,
        replyToId: replyToId,
        replyToMessage: replyToMessage,
        replyToSenderId: replyToSenderId,
        attachmentUrl: attachmentUrl,
        attachmentType: attachmentType,
        attachmentName: attachmentName,
      );

  @override
  Future<ChatMessageEntity> editMessage({
    required String roomId,
    required String messageId,
    required String newMessage,
  }) =>
      localDataSource.editMessage(
        roomId: roomId,
        messageId: messageId,
        newMessage: newMessage,
      );

  @override
  Future<void> markMessagesAsRead(String roomId, String currentUserId) =>
      localDataSource.markMessagesAsRead(roomId, currentUserId);
}
