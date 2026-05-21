import 'package:buildmatch_mobile/features/architect/domain/usecases/get_architect_project_offer_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'architect_project_offer_event.dart';
part 'architect_project_offer_state.dart';

class ArchitectProjectOfferBloc extends Bloc<ArchitectProjectOfferEvent, ArchitectProjectOfferState> {
  final GetArchitectProjectOfferUsecase getPenawaranUseCase;

  ArchitectProjectOfferBloc({required this.getPenawaranUseCase})
      : super(ArchitectProjectOfferState.initial()) {
    on<BudgetMinChanged>(_onBudgetMinChanged);
    on<BudgetMaxChanged>(_onBudgetMaxChanged);
    on<PesanChanged>(_onPesanChanged);
    on<EstimasiWaktuChanged>(_onEstimasiWaktuChanged);
    on<PenawaranSubmitted>(_onPenawaranSubmitted);
    on<PenawaranReset>(_onPenawaranReset);
  }

  void _onBudgetMinChanged(
    BudgetMinChanged event,
    Emitter<ArchitectProjectOfferState> emit,
  ) {
    emit(state.copyWith(
      budgetMin: event.value,
      clearError: true,
    ));
  }

  void _onBudgetMaxChanged(
    BudgetMaxChanged event,
    Emitter<ArchitectProjectOfferState> emit,
  ) {
    emit(state.copyWith(
      budgetMax: event.value,
      clearError: true,
    ));
  }

  void _onPesanChanged(
    PesanChanged event,
    Emitter<ArchitectProjectOfferState> emit,
  ) {
    emit(state.copyWith(pesan: event.value));
  }

  void _onEstimasiWaktuChanged(
    EstimasiWaktuChanged event,
    Emitter<ArchitectProjectOfferState> emit,
  ) {
    emit(state.copyWith(
      estimasiWaktu: event.value,
      clearError: true,
    ));
  }

  Future<void> _onPenawaranSubmitted(
    PenawaranSubmitted event,
    Emitter<ArchitectProjectOfferState> emit,
  ) async {
    if (!state.isFormValid || state.isLoading) return;

    emit(state.copyWith(submitStatus: ProjectOfferSubmitStatus.loading));

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
        submitStatus: ProjectOfferSubmitStatus.failure,
        errorMessage: failure.message,
      )),
      (_) => emit(state.copyWith(
        submitStatus: ProjectOfferSubmitStatus.success,
        clearError: true,
      )),
    );
  }

  void _onPenawaranReset(
    PenawaranReset event,
    Emitter<ArchitectProjectOfferState> emit,
  ) {
    emit(ArchitectProjectOfferState.initial());
  }
}