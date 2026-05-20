import '../../domain/entities/Architect_project_detail_entity.dart';

class ArchitectProjectDetailState {
  final ArchitectProjectDetailEntity? project;
  final bool isLoading;
  final String? error;

  const ArchitectProjectDetailState({
    this.project,
    this.isLoading = false,
    this.error,
  });

  ArchitectProjectDetailState copyWith({
    ArchitectProjectDetailEntity? project,
    bool? isLoading,
    String? error,
  }) {
    return ArchitectProjectDetailState(
      project: project ?? this.project,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
