import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_user_profile_usecase.dart';
import '../../domain/usecases/update_user_profile_usecase.dart';
import 'setting_event.dart';
import 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;

  SettingBloc({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
  }) : super(const SettingInitial()) {
    on<LoadUserProfileEvent>(_onLoadUserProfile);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<ToggleNotificationEvent>(_onToggleNotification);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfileEvent event,
    Emitter<SettingState> emit,
  ) async {
    emit(const SettingLoading());

    final result = await getUserProfileUseCase();

    result.fold(
      (failure) => emit(SettingError(message: failure.message)),
      (user) => emit(SettingLoaded(user: user)),
    );
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfileEvent event,
    Emitter<SettingState> emit,
  ) async {
    // Keep the current user for the loading state
    final currentState = state;
    SettingLoaded? loadedState;

    if (currentState is SettingLoaded) {
      loadedState = currentState;
    } else if (currentState is SettingUpdateError) {
      loadedState = SettingLoaded(user: currentState.user);
    } else if (currentState is SettingUpdateSuccess) {
      loadedState = SettingLoaded(user: currentState.user);
    }

    if (loadedState == null) return;

    emit(SettingUpdateLoading(user: loadedState.user));

    final result = await updateUserProfileUseCase(
      fullName: event.fullName,
      phoneNumber: event.phoneNumber,
      address: event.address,
    );

    result.fold(
      (failure) => emit(
        SettingUpdateError(user: loadedState!.user, message: failure.message),
      ),
      (updatedUser) => emit(SettingUpdateSuccess(user: updatedUser)),
    );
  }

  void _onToggleNotification(
    ToggleNotificationEvent event,
    Emitter<SettingState> emit,
  ) {
    final currentState = state;
    if (currentState is SettingLoaded) {
      emit(currentState.copyWith(notificationEnabled: event.isEnabled));
    }
  }
}
