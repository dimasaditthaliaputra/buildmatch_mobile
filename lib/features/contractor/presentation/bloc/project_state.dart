import '../../domain/entities/project_entity.dart';

class ProjectState {
  final List<ProjectEntity> allProjects;
  final List<ProjectEntity> filteredProjects;
  final ProjectStatus selectedStatus;
  final bool isLoading;

  const ProjectState({
    this.allProjects = const [],
    this.filteredProjects = const [],
    this.selectedStatus = ProjectStatus.offering,
    this.isLoading = false,
  });

  ProjectState copyWith({
    List<ProjectEntity>? allProjects,
    List<ProjectEntity>? filteredProjects,
    ProjectStatus? selectedStatus,
    bool? isLoading,
  }) {
    return ProjectState(
      allProjects: allProjects ?? this.allProjects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
