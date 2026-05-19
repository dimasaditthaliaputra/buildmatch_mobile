part of 'project_contractor_list_bloc.dart';

enum ProjectFilterTab { semua, berjalan, selesai }

abstract class ProjectContractorListState extends Equatable {
  const ProjectContractorListState();

  @override
  List<Object?> get props => [];
}

class ProjectContractorListInitial extends ProjectContractorListState {
  const ProjectContractorListInitial();
}

class ProjectContractorListLoading extends ProjectContractorListState {
  const ProjectContractorListLoading();
}

class ProjectContractorListLoaded extends ProjectContractorListState {
  final List<ProjectContractorListEntity> projects;
  final List<ProjectContractorListEntity> filteredProjects;
  final ProjectFilterTab activeTab;
  final String searchQuery;

  const ProjectContractorListLoaded({
    required this.projects,
    required this.filteredProjects,
    required this.activeTab,
    this.searchQuery = '',
  });

  ProjectContractorListLoaded copyWith({
    List<ProjectContractorListEntity>? projects,
    List<ProjectContractorListEntity>? filteredProjects,
    ProjectFilterTab? activeTab,
    String? searchQuery,
  }) {
    return ProjectContractorListLoaded(
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      activeTab: activeTab ?? this.activeTab,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [projects, filteredProjects, activeTab, searchQuery];
}

class ProjectContractorListError extends ProjectContractorListState {
  final String message;

  const ProjectContractorListError({required this.message});

  @override
  List<Object?> get props => [message];
}
