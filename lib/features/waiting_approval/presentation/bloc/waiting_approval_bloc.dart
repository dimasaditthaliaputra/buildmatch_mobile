import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_verification_status_usecase.dart';
import 'waiting_approval_event.dart';
import 'waiting_approval_state.dart';

class WaitingApprovalBloc extends Bloc<WaitingApprovalEvent, WaitingApprovalState> {
  final GetVerificationStatusUseCase getVerificationStatus;

  WaitingApprovalBloc({
    required this.getVerificationStatus,
  }) : super(WaitingApprovalInitial()) {
    on<GetVerificationStatusEvent>(_onGetVerificationStatus);
  }

  Future<void> _onGetVerificationStatus(
    GetVerificationStatusEvent event,
    Emitter<WaitingApprovalState> emit,
  ) async {
    emit(WaitingApprovalLoading());
    final result = await getVerificationStatus();
    result.fold(
      (failure) => emit(WaitingApprovalError(failure.message)),
      (status) => emit(WaitingApprovalLoaded(status)),
    );
  }
}
