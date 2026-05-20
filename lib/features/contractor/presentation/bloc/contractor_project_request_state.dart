import '../../domain/entities/contractor_project_request_entity.dart';

class ContractorProjectRequestState {
  final List<ContractorProjectRequestEntity> allRequests;
  final List<ContractorProjectRequestEntity> filteredRequests;
  final ProjectRequestStatus selectedStatus;
  final bool isLoading;

  const ContractorProjectRequestState({
    this.allRequests = const [],
    this.filteredRequests = const [],
    this.selectedStatus = ProjectRequestStatus.offering,
    this.isLoading = false,
  });

  ContractorProjectRequestState copyWith({
    List<ContractorProjectRequestEntity>? allRequests,
    List<ContractorProjectRequestEntity>? filteredRequests,
    ProjectRequestStatus? selectedStatus,
    bool? isLoading,
  }) {
    return ContractorProjectRequestState(
      allRequests: allRequests ?? this.allRequests,
      filteredRequests: filteredRequests ?? this.filteredRequests,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}