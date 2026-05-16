import '../../domain/entities/project_detail_entity.dart';

class ProjectDetailState {
  final ProjectDetailEntity? project;
  final bool isLoading;
  final String? error;

  const ProjectDetailState({
    this.project,
    this.isLoading = false,
    this.error,
  });

  ProjectDetailState copyWith({
    ProjectDetailEntity? project,
    bool? isLoading,
    String? error,
  }) {
    return ProjectDetailState(
      project: project ?? this.project,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
