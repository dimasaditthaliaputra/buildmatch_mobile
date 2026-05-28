import '../entities/chat_message_entity.dart';
import '../repositories/inbox_repository.dart';

class SendMessageUseCase {
  final InboxRepository repository;
  SendMessageUseCase(this.repository);

  Future<ChatMessageEntity> call({
    required String roomId,
    required String senderId,
    required String message,
    String? replyToId,
    String? replyToMessage,
    String? replyToSenderId,
    String? attachmentUrl,
    String? attachmentType,
    String? attachmentName,
  }) {
    return repository.sendMessage(
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
  }
}
