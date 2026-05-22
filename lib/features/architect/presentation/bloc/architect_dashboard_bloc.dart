import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/architect_dashboard_entity.dart';
import '../../domain/usecases/get_architect_dashboard_usecase.dart';
part 'architect_dashboard_event.dart';
part 'architect_dashboard_state.dart';

class ArchitectDashboardBloc
    extends Bloc<ArchitectDashboardEvent, ArchitectDashboardState> {
  final GetArchitectDashboardUseCase getDashboardUseCase;

  ArchitectDashboardBloc({required this.getDashboardUseCase})
    : super(const ArchitectDashboardInitial()) {
    on<LoadArchitectDashboard>(_onLoad);
    on<RefreshArchitectDashboard>(_onRefresh);
  }

  Future<void> _onLoad(
    LoadArchitectDashboard event,
    Emitter<ArchitectDashboardState> emit,
  ) async {
    emit(const ArchitectDashboardLoading());
    try {
      final dashboard = await getDashboardUseCase(event.architectId);
      emit(ArchitectDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(ArchitectDashboardError(message: e.toString()));
    }
  }

  Future<void> _onRefresh(
    RefreshArchitectDashboard event,
    Emitter<ArchitectDashboardState> emit,
  ) async {
    try {
      final dashboard = await getDashboardUseCase(event.architectId);
      emit(ArchitectDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(ArchitectDashboardError(message: e.toString()));
    }
  }
}
