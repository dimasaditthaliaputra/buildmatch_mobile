import '../../domain/entities/contractor_project_request_entity.dart';

abstract class ContractorProjectRequestEvent {}

class LoadContractorProjectRequests extends ContractorProjectRequestEvent {}

class FilterContractorProjectRequestsByStatus extends ContractorProjectRequestEvent {
  final ProjectRequestStatus status;
  FilterContractorProjectRequestsByStatus(this.status);
}

class SearchContractorProjectRequests extends ContractorProjectRequestEvent {
  final String query;
  SearchContractorProjectRequests(this.query);
}

class ApplyContractorProjectFilter extends ContractorProjectRequestEvent {
  final int? minBudget;
  final int? maxBudget;
  final String sortOption;
  final String location;

  ApplyContractorProjectFilter({
    this.minBudget,
    this.maxBudget,
    required this.sortOption,
    required this.location,
  });
}