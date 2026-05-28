import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_consultation_rooms_usecase.dart';
import 'inbox_list_event.dart';
import 'inbox_list_state.dart';

class InboxListBloc extends Bloc<InboxListEvent, InboxListState> {
  final GetConsultationRoomsUseCase getConsultationRoomsUseCase;

  InboxListBloc({required this.getConsultationRoomsUseCase})
      : super(InboxListInitial()) {
    on<LoadInboxRoomsEvent>(_onLoadRooms);
  }

  Future<void> _onLoadRooms(
      LoadInboxRoomsEvent event, Emitter<InboxListState> emit) async {
    emit(InboxListLoading());
    try {
      final rooms = await getConsultationRoomsUseCase(event.currentUserId);
      emit(InboxListLoaded(rooms));
    } catch (e) {
      emit(InboxListError(e.toString()));
    }
  }
}
