import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/get_contractor_project_detail.dart';
import 'contractor_project_detail_event.dart';
import 'contractor_project_detail_state.dart';

class ContractorProjectDetailBloc extends Bloc<ContractorProjectDetailEvent, ContractorProjectDetailState> {
  final GetContractorProjectDetail getProjectDetail;

  ContractorProjectDetailBloc(this.getProjectDetail) : super(const ContractorProjectDetailState()) {
    on<LoadContractorProjectDetail>((event, emit) {
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
