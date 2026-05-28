import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_chat_messages_usecase.dart';
import '../../domain/usecases/send_message_usecase.dart';
import 'chat_room_event.dart';
import 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;

  ChatRoomBloc({
    required this.getChatMessagesUseCase,
    required this.sendMessageUseCase,
  }) : super(ChatRoomInitial()) {
    on<LoadChatMessagesEvent>(_onLoadMessages);
    on<SendChatMessageEvent>(_onSendMessage);
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

    emit(currentState.copyWith(isSending: true));
    try {
      final newMessage = await sendMessageUseCase(
        roomId: event.roomId,
        senderId: event.senderId,
        message: event.message,
      );
      final updatedMessages = List.of(currentState.messages)..add(newMessage);
      emit(ChatRoomLoaded(updatedMessages));
    } catch (e) {
      emit(currentState.copyWith(isSending: false));
    }
  }
}
