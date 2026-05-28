import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/client_project_entity.dart';
import '../../domain/usecases/get_client_projects_usecase.dart';
import 'client_project_event.dart';
import 'client_project_state.dart';

class ClientProjectBloc extends Bloc<ClientProjectEvent, ClientProjectState> {
  final GetClientPenawaranUseCase getPenawaranUseCase;
  final GetClientAllProjectsUseCase getAllProjectsUseCase;

  // Cache so switching tabs doesn't re-fetch
  List<ClientProjectEntity> _penawaranCache = [];
  List<ClientProjectEntity> _allProjectsCache = [];

  ClientProjectBloc({
    required this.getPenawaranUseCase,
    required this.getAllProjectsUseCase,
  }) : super(ClientProjectInitial()) {
    on<LoadClientPenawaran>(_onLoadPenawaran);
    on<LoadAllClientProjects>(_onLoadAllProjects);
    on<SearchClientProjects>(_onSearchProjects);
    on<SwitchProjectTab>(_onSwitchTab);
  }

  Future<void> _onLoadPenawaran(
    LoadClientPenawaran event,
    Emitter<ClientProjectState> emit,
  ) async {
    emit(ClientProjectLoading());
    try {
      _penawaranCache = await getPenawaranUseCase(event.clientId);
      emit(ClientProjectLoaded(
        projects: _penawaranCache,
        filteredProjects: _penawaranCache,
        currentTab: 0,
      ));
    } catch (e) {
      emit(ClientProjectError(message: e.toString()));
    }
  }

  Future<void> _onLoadAllProjects(
    LoadAllClientProjects event,
    Emitter<ClientProjectState> emit,
  ) async {
    emit(ClientProjectLoading());
    try {
      _allProjectsCache = await getAllProjectsUseCase(event.clientId);
      emit(ClientProjectLoaded(
        projects: _allProjectsCache,
        filteredProjects: _allProjectsCache,
        currentTab: 1,
      ));
    } catch (e) {
      emit(ClientProjectError(message: e.toString()));
    }
  }

  Future<void> _onSwitchTab(
    SwitchProjectTab event,
    Emitter<ClientProjectState> emit,
  ) async {
    final currentState = state;
    if (currentState is ClientProjectLoaded) {
      final targetProjects =
          event.tabIndex == 0 ? _allProjectsCache : _penawaranCache;

      // If cache empty, fetch
      if (targetProjects.isEmpty) {
        emit(ClientProjectLoading());
        try {
          final fetched = event.tabIndex == 0
              ? await getAllProjectsUseCase('current_user')
              : await getPenawaranUseCase('current_user');

          if (event.tabIndex == 0) {
            _allProjectsCache = fetched;
          } else {
            _penawaranCache = fetched;
          }

          emit(ClientProjectLoaded(
            projects: fetched,
            filteredProjects: fetched,
            currentTab: event.tabIndex,
          ));
        } catch (e) {
          emit(ClientProjectError(message: e.toString()));
        }
        return;
      }

      emit(currentState.copyWith(
        projects: targetProjects,
        filteredProjects: targetProjects,
        currentTab: event.tabIndex,
        searchQuery: '',
      ));
    }
  }

  void _onSearchProjects(
    SearchClientProjects event,
    Emitter<ClientProjectState> emit,
  ) {
    final currentState = state;
    if (currentState is ClientProjectLoaded) {
      final query = event.query.toLowerCase();
      final filtered = query.isEmpty
          ? currentState.projects
          : currentState.projects
              .where((p) =>
                  p.name.toLowerCase().contains(query) ||
                  p.location.toLowerCase().contains(query))
              .toList();

      emit(currentState.copyWith(
        filteredProjects: filtered,
        searchQuery: event.query,
      ));
    }
  }
}
