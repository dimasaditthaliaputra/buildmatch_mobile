import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import '../../domain/usecases/edit_message_usecase.dart';
import 'chat_room_event.dart';
import 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final EditMessageUseCase editMessageUseCase;

  ChatRoomBloc({
    required this.getChatMessagesUseCase,
    required this.sendMessageUseCase,
    required this.editMessageUseCase,
  }) : super(ChatRoomInitial()) {
    on<LoadChatMessagesEvent>(_onLoadMessages);
    on<SendChatMessageEvent>(_onSendMessage);
    on<EditChatMessageEvent>(_onEditMessage);
    on<SetReplyMessageEvent>(_onSetReply);
    on<ClearReplyMessageEvent>(_onClearReply);
    on<SetEditingMessageEvent>(_onSetEditing);
    on<ClearEditingMessageEvent>(_onClearEditing);
  }

  Future<void> _onLoadMessages(
      LoadChatMessagesEvent event, Emitter<ChatRoomState> emit) async {
    emit(ChatRoomLoading());
    try {
      final messages = await getChatMessagesUseCase(event.roomId);
      emit(ChatRoomLoaded(messages));
    } catch (e) {
      emit(ChatRoomError(e.toString()));
    }
  }

  Future<void> _onSendMessage(
      SendChatMessageEvent event, Emitter<ChatRoomState> emit) async {
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;
    emit(currentState.copyWith(isSending: true, clearReply: false));
    try {
      final newMessage = await sendMessageUseCase(
        roomId: event.roomId,
        senderId: event.senderId,
        message: event.message,
        replyToId: event.replyTo?.id,
        replyToMessage: event.replyTo?.message,
        replyToSenderId: event.replyTo?.senderId,
        attachmentUrl: event.attachmentUrl,
        attachmentType: event.attachmentType,
        attachmentName: event.attachmentName,
      );
      final updated = List.of(currentState.messages)..add(newMessage);
      emit(currentState.copyWith(messages: updated, isSending: false, clearReply: true, clearEditing: true));
    } catch (e) {
      emit(currentState.copyWith(isSending: false));
    }
  }

  Future<void> _onEditMessage(
      EditChatMessageEvent event, Emitter<ChatRoomState> emit) async {
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;
    emit(currentState.copyWith(isSending: true));
    try {
      final edited = await editMessageUseCase(
        roomId: event.roomId,
        messageId: event.messageId,
        newMessage: event.newMessage,
      );
      final updated = currentState.messages.map((m) {
        return m.id == edited.id ? edited : m;
      }).toList();
      emit(currentState.copyWith(messages: updated, isSending: false, clearEditing: true));
    } catch (e) {
      emit(currentState.copyWith(isSending: false));
    }
  }

  void _onSetReply(SetReplyMessageEvent event, Emitter<ChatRoomState> emit) {
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;
    emit(currentState.copyWith(replyingTo: event.message, clearEditing: true));
  }

  void _onClearReply(ClearReplyMessageEvent event, Emitter<ChatRoomState> emit) {
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;
    emit(currentState.copyWith(clearReply: true));
  }

  void _onSetEditing(SetEditingMessageEvent event, Emitter<ChatRoomState> emit) {
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;
    emit(currentState.copyWith(editingMessage: event.message, clearReply: true));
  }

  void _onClearEditing(ClearEditingMessageEvent event, Emitter<ChatRoomState> emit) {
    final currentState = state;
    if (currentState is! ChatRoomLoaded) return;
    emit(currentState.copyWith(clearEditing: true));
  }
}
