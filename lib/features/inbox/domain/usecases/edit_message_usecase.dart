import '../entities/chat_message_entity.dart';
import '../repositories/inbox_repository.dart';

class EditMessageUseCase {
  final InboxRepository repository;
  EditMessageUseCase(this.repository);

  Future<ChatMessageEntity> call({
    required String roomId,
    required String messageId,
    required String newMessage,
  }) {
    return repository.editMessage(
      roomId: roomId,
      messageId: messageId,
      newMessage: newMessage,
    );
  }
}
