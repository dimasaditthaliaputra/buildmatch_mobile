import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_client_dashboard_usecase.dart';
import 'client_dashboard_event.dart';
import 'client_dashboard_state.dart';

class ClientDashboardBloc
    extends Bloc<ClientDashboardEvent, ClientDashboardState> {
  final GetClientDashboardUseCase getDashboardUseCase;

  ClientDashboardBloc({required this.getDashboardUseCase})
      : super(ClientDashboardInitial()) {
    on<LoadClientDashboard>(_onLoadDashboard);
    on<RefreshClientDashboard>(_onRefreshDashboard);
  }

  Future<void> _onLoadDashboard(
    LoadClientDashboard event,
    Emitter<ClientDashboardState> emit,
  ) async {
    emit(ClientDashboardLoading());
    try {
      final dashboard = await getDashboardUseCase(event.clientId);
      emit(ClientDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(ClientDashboardError(message: e.toString()));
    }
  }

  Future<void> _onRefreshDashboard(
    RefreshClientDashboard event,
    Emitter<ClientDashboardState> emit,
  ) async {
    try {
      final dashboard = await getDashboardUseCase(event.clientId);
      emit(ClientDashboardLoaded(dashboard: dashboard));
    } catch (e) {
      emit(ClientDashboardError(message: e.toString()));
    }
  }
}
