import '../../domain/entities/contractor_project_detail_entity.dart';

class ContractorProjectDetailState {
  final ContractorProjectDetailEntity? project;
  final bool isLoading;
  final String? error;

  const ContractorProjectDetailState({
    this.project,
    this.isLoading = false,
    this.error,
  });

  ContractorProjectDetailState copyWith({
    ContractorProjectDetailEntity? project,
    bool? isLoading,
    String? error,
  }) {
    return ContractorProjectDetailState(
      project: project ?? this.project,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
