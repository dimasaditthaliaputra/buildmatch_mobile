import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/contractor_dashboard_entity.dart';
import '../../domain/usecases/get_contractor_dashboard_usecase.dart';
part 'contractor_dashboard_event.dart';
part 'contractor_dashboard_state.dart';

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