import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/architect_project_list_entity.dart';
import '../../domain/usecases/get_architect_all_project.dart';
import '../../domain/usecases/get_architect_project_by_status.dart';

part 'architect_project_list_event.dart';
part 'architect_project_list_state.dart';

class ArchitectProjectListBloc
    extends Bloc<ArchitectProjectListEvent, ArchitectProjectListState> {
  final ArchitectGetAllProjects getAllProjects;
  final ArchitectGetProjectsByStatus getProjectsByStatus;

  ArchitectProjectListBloc({
    required this.getAllProjects,
    required this.getProjectsByStatus,
  }) : super(const ProjectArchitectListInitial()) {
    on<LoadAllProjects>(_onLoadAllProjects);
    on<LoadProjectsByStatus>(_onLoadProjectsByStatus);
    on<SearchProjects>(_onSearchProjects);
    on<ChangeFilterTab>(_onChangeFilterTab);
  }

  Future<void> _onLoadAllProjects(
    LoadAllProjects event,
    Emitter<ArchitectProjectListState> emit,
  ) async {
    emit(const ProjectArchitectListLoading());
    final result = await getAllProjects();
    result.fold(
      (failure) => emit(ProjectArchitectListError(message: failure.message)),
      (projects) => emit(
        ProjectArchitectListLoaded(
          projects: projects,
          filteredProjects: projects,
          activeTab: ProjectFilterTab.semua,
        ),
      ),
    );
  }


  Future<void> _onLoadProjectsByStatus(
    LoadProjectsByStatus event,
    Emitter<ArchitectProjectListState> emit,
  ) async {
    emit(const ProjectArchitectListLoading());
    final result = await getProjectsByStatus(event.status);
    result.fold(
      (failure) => emit(ProjectArchitectListError(message: failure.message)),
      (projects) {
        final tab = event.status == ProjectStatus.berjalan
            ? ProjectFilterTab.berjalan
            : ProjectFilterTab.selesai;
        emit(
          ProjectArchitectListLoaded(
            projects: projects,
            filteredProjects: projects,
            activeTab: tab,
          ),
        );
      },
    );
  }

  void _onSearchProjects(
    SearchProjects event,
    Emitter<ArchitectProjectListState> emit,
  ) {
    if (state is ProjectArchitectListLoaded) {
      final currentState = state as ProjectArchitectListLoaded;
      final query = event.query.toLowerCase();
      final filtered = query.isEmpty
          ? currentState.projects
          : currentState.projects
              .where(
                (p) =>
                    p.name.toLowerCase().contains(query) ||
                    p.clientName.toLowerCase().contains(query) ||
                    p.location.toLowerCase().contains(query),
              )
              .toList();

      emit(
        currentState.copyWith(
          filteredProjects: filtered,
          searchQuery: event.query,
        ),
      );
    }
  }

  void _onChangeFilterTab(
    ChangeFilterTab event,
    Emitter<ArchitectProjectListState> emit,
  ) {
    if (state is ProjectArchitectListLoaded) {
      final currentState = state as ProjectArchitectListLoaded;

      if (event.tab == ProjectFilterTab.semua) {
        add(const LoadAllProjects());
      } else if (event.tab == ProjectFilterTab.berjalan) {
        add(const LoadProjectsByStatus(ProjectStatus.berjalan));
      } else {
        add(const LoadProjectsByStatus(ProjectStatus.selesai));
      }
    }
  }
}
