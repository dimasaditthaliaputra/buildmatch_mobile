import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/project_entity.dart';
import '../../domain/usecases/get_projects.dart';
import 'project_event.dart';
import 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final GetProjects getProjects;

  ProjectBloc(this.getProjects) : super(const ProjectState()) {
    on<LoadProjects>((event, emit) {
      emit(state.copyWith(isLoading: true));
      final projects = getProjects.execute();
      final filtered = projects
          .where((p) => p.status == ProjectStatus.offering)
          .toList();
      emit(state.copyWith(
        isLoading: false,
        allProjects: projects,
        filteredProjects: filtered,
        selectedStatus: ProjectStatus.offering,
      ));
    });

    on<FilterProjectsByStatus>((event, emit) {
      final filtered = state.allProjects
          .where((p) => p.status == event.status)
          .toList();
      emit(state.copyWith(
        filteredProjects: filtered,
        selectedStatus: event.status,
      ));
    });
  }
}
