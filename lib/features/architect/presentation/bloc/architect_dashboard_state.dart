part of 'architect_dashboard_bloc.dart';

abstract class ArchitectDashboardState extends Equatable {
  const ArchitectDashboardState();

  @override
  List<Object?> get props => [];
}

class ArchitectDashboardInitial extends ArchitectDashboardState {
  const ArchitectDashboardInitial();
}

class ArchitectDashboardLoading extends ArchitectDashboardState {
  const ArchitectDashboardLoading();
}

class ArchitectDashboardLoaded extends ArchitectDashboardState {
  final ArchitectDashboardEntity dashboard;
  const ArchitectDashboardLoaded({required this.dashboard});

  @override
  List<Object?> get props => [dashboard];
}

class ArchitectDashboardError extends ArchitectDashboardState {
  final String message;
  const ArchitectDashboardError({required this.message});

  @override
  List<Object?> get props => [message];
}