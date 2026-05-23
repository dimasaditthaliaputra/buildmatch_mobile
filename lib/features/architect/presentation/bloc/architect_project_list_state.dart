part of 'architect_project_list_bloc.dart';

enum ProjectFilterTab { semua, berjalan, selesai }

abstract class ArchitectProjectListState extends Equatable {
  const ArchitectProjectListState();

  @override
  List<Object?> get props => [];
}

class ProjectArchitectListInitial extends ArchitectProjectListState {
  const ProjectArchitectListInitial();
}

class ProjectArchitectListLoading extends ArchitectProjectListState {
  const ProjectArchitectListLoading();
}

class ProjectArchitectListLoaded extends ArchitectProjectListState {
  final List<ArchitectProjectListEntity> projects;
  final List<ArchitectProjectListEntity> filteredProjects;
  final ProjectFilterTab activeTab;
  final String searchQuery;

  const ProjectArchitectListLoaded({
    required this.projects,
    required this.filteredProjects,
    required this.activeTab,
    this.searchQuery = '',
  });

  ProjectArchitectListLoaded copyWith({
    List<ArchitectProjectListEntity>? projects,
    List<ArchitectProjectListEntity>? filteredProjects,
    ProjectFilterTab? activeTab,
    String? searchQuery,
  }) {
    return ProjectArchitectListLoaded(
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      activeTab: activeTab ?? this.activeTab,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [projects, filteredProjects, activeTab, searchQuery];
}

class ProjectArchitectListError extends ArchitectProjectListState {
  final String message;

  const ProjectArchitectListError({required this.message});

  @override
  List<Object?> get props => [message];
}
