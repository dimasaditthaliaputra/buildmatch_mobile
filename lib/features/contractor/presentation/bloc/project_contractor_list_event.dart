part of 'project_contractor_list_bloc.dart';

abstract class ProjectContractorListEvent extends Equatable {
  const ProjectContractorListEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProjects extends ProjectContractorListEvent {
  const LoadAllProjects();
}

class LoadProjectsByStatus extends ProjectContractorListEvent {
  final ProjectStatus status;

  const LoadProjectsByStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class SearchProjects extends ProjectContractorListEvent {
  final String query;

  const SearchProjects(this.query);

  @override
  List<Object?> get props => [query];
}

class ChangeFilterTab extends ProjectContractorListEvent {
  final ProjectFilterTab tab;

  const ChangeFilterTab(this.tab);

  @override
  List<Object?> get props => [tab];
}
