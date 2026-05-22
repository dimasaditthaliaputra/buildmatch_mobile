part of 'architect_project_list_bloc.dart';

abstract class ArchitectProjectListEvent extends Equatable {
  const ArchitectProjectListEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProjects extends ArchitectProjectListEvent {
  const LoadAllProjects();
}

class LoadProjectsByStatus extends ArchitectProjectListEvent {
  final ProjectStatus status;

  const LoadProjectsByStatus(this.status);

  @override
  List<Object?> get props => [status];
}

class SearchProjects extends ArchitectProjectListEvent {
  final String query;

  const SearchProjects(this.query);

  @override
  List<Object?> get props => [query];
}

class ChangeFilterTab extends ArchitectProjectListEvent {
  final ProjectFilterTab tab;

  const ChangeFilterTab(this.tab);

  @override
  List<Object?> get props => [tab];
}
