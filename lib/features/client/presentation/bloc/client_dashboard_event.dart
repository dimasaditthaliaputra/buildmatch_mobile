import 'package:equatable/equatable.dart';

abstract class ClientDashboardEvent extends Equatable {
  const ClientDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadClientDashboard extends ClientDashboardEvent {
  final String clientId;

  const LoadClientDashboard({required this.clientId});

  @override
  List<Object?> get props => [clientId];
}

class RefreshClientDashboard extends ClientDashboardEvent {
  final String clientId;

  const RefreshClientDashboard({required this.clientId});

  @override
  List<Object?> get props => [clientId];
}

class ToggleFavoriteProject extends ClientDashboardEvent {
  final String projectId;

  const ToggleFavoriteProject({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}
