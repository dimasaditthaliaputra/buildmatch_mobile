part of 'architect_dashboard_bloc.dart';

abstract class ArchitectDashboardEvent extends Equatable {
  const ArchitectDashboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadArchitectDashboard extends ArchitectDashboardEvent {
  final String architectId;
  const LoadArchitectDashboard({required this.architectId});

  @override
  List<Object?> get props => [architectId];
}

class RefreshArchitectDashboard extends ArchitectDashboardEvent {
  final String architectId;
  const RefreshArchitectDashboard({required this.architectId});

  @override
  List<Object?> get props => [architectId];
}