import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/setup_profile_usecase.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final SetupProfileUseCase setupProfileUseCase;

  ProfileBloc({required this.setupProfileUseCase}) : super(ProfileInitial()) {
    on<SubmitProfileEvent>(_onSubmitProfile);
  }

  Future<void> _onSubmitProfile(
    SubmitProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileSubmitting());
    final result = await setupProfileUseCase(event.profile);
    result.fold(
      (failure) => emit(ProfileSubmitFailure(failure.message)),
      (_) => emit(ProfileSubmitSuccess()),
    );
  }
}
