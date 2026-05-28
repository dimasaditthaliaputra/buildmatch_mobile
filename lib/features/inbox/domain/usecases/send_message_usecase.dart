import '../entities/chat_message_entity.dart';
import '../repositories/inbox_repository.dart';

class SendMessageUseCase {
  final InboxRepository repository;
  SendMessageUseCase(this.repository);

  Future<ChatMessageEntity> call({
    required String roomId,
    required String senderId,
    required String message,
  }) {
    return repository.sendMessage(
      roomId: roomId,
      senderId: senderId,
      message: message,
    );
  }
}
