import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_project_detail.dart';
import 'project_detail_event.dart';
import 'project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  final GetProjectDetail getProjectDetail;

  ProjectDetailBloc(this.getProjectDetail) : super(const ProjectDetailState()) {
    on<LoadProjectDetail>((event, emit) {
      emit(state.copyWith(isLoading: true));
      try {
        final project = getProjectDetail.execute(event.projectId);
        emit(state.copyWith(isLoading: false, project: project));
      } catch (e) {
        emit(state.copyWith(isLoading: false, error: e.toString()));
      }
    });
  }
}
