part of 'contractor_dashboard_bloc.dart';

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