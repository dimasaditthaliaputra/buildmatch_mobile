import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/contractor_project_list_entity.dart';
import '../../domain/usecases/get_all_project.dart';
import '../../domain/usecases/get_project_by_status.dart';

part 'contractor_project_list_event.dart';
part 'contractor_project_list_state.dart';

class ContractorProjectListBloc
    extends Bloc<ContractorProjectListEvent, ContractorProjectListState> {
  final GetAllProjects getAllProjects;
  final GetProjectsByStatus getProjectsByStatus;

  ContractorProjectListBloc({
    required this.getAllProjects,
    required this.getProjectsByStatus,
  }) : super(const ProjectContractorListInitial()) {
    on<LoadAllProjects>(_onLoadAllProjects);
    on<LoadProjectsByStatus>(_onLoadProjectsByStatus);
    on<SearchProjects>(_onSearchProjects);
    on<ChangeFilterTab>(_onChangeFilterTab);
  }

  Future<void> _onLoadAllProjects(
    LoadAllProjects event,
    Emitter<ContractorProjectListState> emit,
  ) async {
    emit(const ProjectContractorListLoading());
    final result = await getAllProjects();
    result.fold(
      (failure) => emit(ProjectContractorListError(message: failure.message)),
      (projects) => emit(
        ProjectContractorListLoaded(
          projects: projects,
          filteredProjects: projects,
          activeTab: ProjectFilterTab.semua,
        ),
      ),
    );
  }

  Future<void> _onLoadProjectsByStatus(
    LoadProjectsByStatus event,
    Emitter<ContractorProjectListState> emit,
  ) async {
    emit(const ProjectContractorListLoading());
    final result = await getProjectsByStatus(event.status);
    result.fold(
      (failure) => emit(ProjectContractorListError(message: failure.message)),
      (projects) {
        final tab = event.status == ProjectStatus.berjalan
            ? ProjectFilterTab.berjalan
            : ProjectFilterTab.selesai;
        emit(
          ProjectContractorListLoaded(
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
    Emitter<ContractorProjectListState> emit,
  ) {
    if (state is ProjectContractorListLoaded) {
      final currentState = state as ProjectContractorListLoaded;
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
    Emitter<ContractorProjectListState> emit,
  ) {
    if (state is ProjectContractorListLoaded) {
      final currentState = state as ProjectContractorListLoaded;

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
