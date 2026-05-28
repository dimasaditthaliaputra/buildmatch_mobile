import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/notification_repository.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepository repository;

  NotificationBloc({required this.repository}) : super(NotificationInitial()) {
    on<GetNotificationsEvent>((event, emit) async {
      emit(NotificationLoading());
      
      final result = await repository.getNotifications();
      
      result.fold(
        (failure) => emit(NotificationError(message: failure.message)),
        (notifications) => emit(NotificationLoaded(notifications: notifications)),
      );
    });
  }
}
