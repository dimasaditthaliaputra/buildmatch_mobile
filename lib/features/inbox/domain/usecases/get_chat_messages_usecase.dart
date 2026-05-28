import '../entities/chat_message_entity.dart';
import '../repositories/inbox_repository.dart';

class GetChatMessagesUseCase {
  final InboxRepository repository;
  GetChatMessagesUseCase(this.repository);

  Future<List<ChatMessageEntity>> call(String roomId) {
    return repository.getChatMessages(roomId);
  }
}
