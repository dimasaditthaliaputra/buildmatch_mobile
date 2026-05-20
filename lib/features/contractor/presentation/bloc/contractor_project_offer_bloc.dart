import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_contractor_project_offer_usecase.dart';
part 'contractor_project_offer_event.dart';
part 'contractor_project_offer_state.dart';

class ContractorProjectOfferBloc extends Bloc<ContractorProjectOfferEvent, ContractorProjectOfferState> {
  final GetContractorProjectOfferUsecase getPenawaranUseCase;

  ContractorProjectOfferBloc({required this.getPenawaranUseCase})
      : super(ContractorProjectOfferState.initial()) {
    on<BudgetMinChanged>(_onBudgetMinChanged);
    on<BudgetMaxChanged>(_onBudgetMaxChanged);
    on<PesanChanged>(_onPesanChanged);
    on<EstimasiWaktuChanged>(_onEstimasiWaktuChanged);
    on<PenawaranSubmitted>(_onPenawaranSubmitted);
    on<PenawaranReset>(_onPenawaranReset);
  }

  void _onBudgetMinChanged(
    BudgetMinChanged event,
    Emitter<ContractorProjectOfferState> emit,
  ) {
    emit(state.copyWith(
      budgetMin: event.value,
      clearError: true,
    ));
  }

  void _onBudgetMaxChanged(
    BudgetMaxChanged event,
    Emitter<ContractorProjectOfferState> emit,
  ) {
    emit(state.copyWith(
      budgetMax: event.value,
      clearError: true,
    ));
  }

  void _onPesanChanged(
    PesanChanged event,
    Emitter<ContractorProjectOfferState> emit,
  ) {
    emit(state.copyWith(pesan: event.value));
  }

  void _onEstimasiWaktuChanged(
    EstimasiWaktuChanged event,
    Emitter<ContractorProjectOfferState> emit,
  ) {
    emit(state.copyWith(
      estimasiWaktu: event.value,
      clearError: true,
    ));
  }

  Future<void> _onPenawaranSubmitted(
    PenawaranSubmitted event,
    Emitter<ContractorProjectOfferState> emit,
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
    Emitter<ContractorProjectOfferState> emit,
  ) {
    emit(ContractorProjectOfferState.initial());
  }
}