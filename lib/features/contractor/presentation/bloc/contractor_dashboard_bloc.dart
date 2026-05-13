import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';
import '../../domain/usecases/get_contractor_dashboard_usecase.dart';

// ─── Events ───────────────────────────────────────────────────────────────────
abstract class ContractorDashboardEvent extends Equatable {
  const ContractorDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadContractorDashboard extends ContractorDashboardEvent {
  final String contractorId;
  const LoadContractorDashboard({required this.contractorId});

  @override
  List<Object?> get props => [contractorId];
}

class RefreshContractorDashboard extends ContractorDashboardEvent {
  final String contractorId;
  const RefreshContractorDashboard({required this.contractorId});

  @override
  List<Object?> get props => [contractorId];
}

// ─── States ───────────────────────────────────────────────────────────────────
abstract class ContractorDashboardState extends Equatable {
  const ContractorDashboardState();

  @override
  List<Object?> get props => [];
}

class ContractorDashboardInitial extends ContractorDashboardState {
  const ContractorDashboardInitial();
}

class ContractorDashboardLoading extends ContractorDashboardState {
  const ContractorDashboardLoading();
}

class ContractorDashboardLoaded extends ContractorDashboardState {
  final ContractorDashboardEntity dashboard;
  const ContractorDashboardLoaded({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}

class ContractorDashboardError extends ContractorDashboardState {
  final String message;
  const ContractorDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}

// ─── BLoC ─────────────────────────────────────────────────────────────────────
class ContractorDashboardBloc
    extends Bloc<ContractorDashboardEvent, ContractorDashboardState> {
  final GetContractorDashboardUseCase getDashboardUseCase;

  ContractorDashboardBloc({required this.getDashboardUseCase})
    : super(const ContractorDashboardInitial()) {
    on<LoadContractorDashboard>(_onLoad);
    on<RefreshContractorDashboard>(_onRefresh);
  }

  Future<void> _onLoad(
    LoadContractorDashboard event,
    Emitter<ContractorDashboardState> emit,
  ) async {
    emit(const ContractorDashboardLoading());
    try {
      final dashboard = await getDashboardUseCase(event.contractorId);
      emit(ContractorDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(ContractorDashboardError(message: e.toString()));
    }
  }

  Future<void> _onRefresh(
    RefreshContractorDashboard event,
    Emitter<ContractorDashboardState> emit,
  ) async {
    try {
      final dashboard = await getDashboardUseCase(event.contractorId);
      emit(ContractorDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(ContractorDashboardError(message: e.toString()));
    }
  }
}