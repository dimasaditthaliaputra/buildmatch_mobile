import 'package:equatable/equatable.dart';
import '../../domain/entities/client_project_entity.dart';

abstract class ClientProjectState extends Equatable {
  const ClientProjectState();

  @override
  List<Object?> get props => [];
}

class ClientProjectInitial extends ClientProjectState {}

class ClientProjectLoading extends ClientProjectState {}

class ClientProjectLoaded extends ClientProjectState {
  final List<ClientProjectEntity> projects;
  final List<ClientProjectEntity> filteredProjects;
  final int currentTab; // 0 = Penawaran, 1 = Semua Proyek
  final String searchQuery;

  const ClientProjectLoaded({
    required this.projects,
    required this.filteredProjects,
    required this.currentTab,
    this.searchQuery = '',
  });

  ClientProjectLoaded copyWith({
    List<ClientProjectEntity>? projects,
    List<ClientProjectEntity>? filteredProjects,
    int? currentTab,
    String? searchQuery,
  }) {
    return ClientProjectLoaded(
      projects: projects ?? this.projects,
      filteredProjects: filteredProjects ?? this.filteredProjects,
      currentTab: currentTab ?? this.currentTab,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props =>
      [projects, filteredProjects, currentTab, searchQuery];
}

class ClientProjectError extends ClientProjectState {
  final String message;

  const ClientProjectError({required this.message});

  @override
  List<Object?> get props => [message];
}
