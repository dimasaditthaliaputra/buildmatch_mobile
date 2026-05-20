import 'package:equatable/equatable.dart';
import '../../domain/entities/client_dashboard_entity.dart';

abstract class ClientDashboardState extends Equatable {
  const ClientDashboardState();

  @override
  List<Object?> get props => [];
}

class ClientDashboardInitial extends ClientDashboardState {}

class ClientDashboardLoading extends ClientDashboardState {}

class ClientDashboardLoaded extends ClientDashboardState {
  final ClientDashboardEntity dashboard;

  const ClientDashboardLoaded({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}

class ClientDashboardError extends ClientDashboardState {
  final String message;

  const ClientDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}
