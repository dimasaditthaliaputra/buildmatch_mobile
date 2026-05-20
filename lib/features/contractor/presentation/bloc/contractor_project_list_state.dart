part of 'contractor_project_list_bloc.dart';

enum ProjectFilterTab { semua, berjalan, selesai }

abstract class ContractorProjectListState extends Equatable {
  const ContractorProjectListState();

  @override
  List<Object?> get props => [];
}

class ProjectContractorListInitial extends ContractorProjectListState {
  const ProjectContractorListInitial();
}

class ProjectContractorListLoading extends ContractorProjectListState {
  const ProjectContractorListLoading();
}

class ProjectContractorListLoaded extends ContractorProjectListState {
  final List<ContractorProjectListEntity> projects;
  final List<ContractorProjectListEntity> filteredProjects;
  final ProjectFilterTab activeTab;
  final String searchQuery;

  const ProjectContractorListLoaded({
    required this.projects,
    required this.filteredProjects,
    required this.activeTab,
    this.searchQuery = '',
  });

  ProjectContractorListLoaded copyWith({
    List<ContractorProjectListEntity>? projects,
    List<ContractorProjectListEntity>? filteredProjects,
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

class ProjectContractorListError extends ContractorProjectListState {
  final String message;

  const ProjectContractorListError({required this.message});

  @override
  List<Object?> get props => [message];
}
