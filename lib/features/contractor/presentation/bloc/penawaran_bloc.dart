import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_penawaran_usecase.dart';
part 'penawaran_event.dart';
part 'penawaran_state.dart';

class PenawaranBloc extends Bloc<PenawaranEvent, PenawaranState> {
  final GetPenawaranUsecase getPenawaranUseCase;

  PenawaranBloc({required this.getPenawaranUseCase})
      : super(PenawaranState.initial()) {
    on<BudgetMinChanged>(_onBudgetMinChanged);
    on<BudgetMaxChanged>(_onBudgetMaxChanged);
    on<PesanChanged>(_onPesanChanged);
    on<EstimasiWaktuChanged>(_onEstimasiWaktuChanged);
    on<PenawaranSubmitted>(_onPenawaranSubmitted);
    on<PenawaranReset>(_onPenawaranReset);
  }

  void _onBudgetMinChanged(
    BudgetMinChanged event,
    Emitter<PenawaranState> emit,
  ) {
    emit(state.copyWith(
      budgetMin: event.value,
      clearError: true,
    ));
  }

  void _onBudgetMaxChanged(
    BudgetMaxChanged event,
    Emitter<PenawaranState> emit,
  ) {
    emit(state.copyWith(
      budgetMax: event.value,
      clearError: true,
    ));
  }

  void _onPesanChanged(
    PesanChanged event,
    Emitter<PenawaranState> emit,
  ) {
    emit(state.copyWith(pesan: event.value));
  }

  void _onEstimasiWaktuChanged(
    EstimasiWaktuChanged event,
    Emitter<PenawaranState> emit,
  ) {
    emit(state.copyWith(
      estimasiWaktu: event.value,
      clearError: true,
    ));
  }

  Future<void> _onPenawaranSubmitted(
    PenawaranSubmitted event,
    Emitter<PenawaranState> emit,
  ) async {
    if (!state.isFormValid || state.isLoading) return;

    emit(state.copyWith(submitStatus: PenawaranSubmitStatus.loading));

    final result = await getPenawaranUseCase(
      GetPenawaranParams(
        projectId: event.projectId,
        budgetMin: state.budgetMin!,
        budgetMax: state.budgetMax!,
        pesan: state.pesan.trim(),
        estimasiWaktu: state.estimasiWaktu!,
      ),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        submitStatus: PenawaranSubmitStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        submitStatus: PenawaranSubmitStatus.success,
        clearError: true,
      )),
    );
  }

  void _onPenawaranReset(
    PenawaranReset event,
    Emitter<PenawaranState> emit,
  ) {
    emit(PenawaranState.initial());
  }
}