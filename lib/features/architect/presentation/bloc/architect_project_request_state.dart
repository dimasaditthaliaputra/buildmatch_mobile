import '../../domain/entities/architect_project_request_entity.dart';

class ArchitectProjectRequestState {
  final List<ArchitectProjectRequestEntity> allRequests;
  final List<ArchitectProjectRequestEntity> filteredRequests;
  final ProjectRequestStatus selectedStatus;
  final bool isLoading;

  const ArchitectProjectRequestState({
    this.allRequests = const [],
    this.filteredRequests = const [],
    this.selectedStatus = ProjectRequestStatus.offering,
    this.isLoading = false,
  });

  ArchitectProjectRequestState copyWith({
    List<ArchitectProjectRequestEntity>? allRequests,
    List<ArchitectProjectRequestEntity>? filteredRequests,
    ProjectRequestStatus? selectedStatus,
    bool? isLoading,
  }) {
    return ArchitectProjectRequestState(
      allRequests: allRequests ?? this.allRequests,
      filteredRequests: filteredRequests ?? this.filteredRequests,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}