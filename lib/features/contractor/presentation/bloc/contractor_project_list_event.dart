part of 'contractor_project_list_bloc.dart';

abstract class ContractorProjectListEvent extends Equatable {
  const ContractorProjectListEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProjects extends ContractorProjectListEvent {
  const LoadAllProjects();
}

class LoadProjectsByStatus extends ContractorProjectListEvent {
  final ProjectStatus status;

  const LoadProjectsByStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class SearchProjects extends ContractorProjectListEvent {
  final String query;

  const SearchProjects(this.query);

  @override
  List<Object?> get props => [query];
}

class ChangeFilterTab extends ContractorProjectListEvent {
  final ProjectFilterTab tab;

  const ChangeFilterTab(this.tab);

  @override
  List<Object?> get props => [tab];
}
