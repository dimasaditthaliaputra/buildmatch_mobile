part of 'contractor_dashboard_bloc.dart';

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