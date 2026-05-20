import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_Architect_project_detail.dart';
import 'architect_project_detail_event.dart';
import 'architect_project_detail_state.dart';

class ArchitectProjectDetailBloc extends Bloc<ArchitectProjectDetailEvent, ArchitectProjectDetailState> {
  final GetArchitectProjectDetail getProjectDetail;

  ArchitectProjectDetailBloc(this.getProjectDetail) : super(const ArchitectProjectDetailState()) {
    on<LoadArchitectProjectDetail>((event, emit) {
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
