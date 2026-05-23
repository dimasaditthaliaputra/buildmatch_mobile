import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_milestones_contractor_usecase.dart';
import 'milestone_contractor_event.dart';
import 'milestone_contractor_state.dart';

class MilestoneContractorBloc
    extends Bloc<MilestoneContractorEvent, MilestoneContractorState> {
  final GetMilestonesUseCase getMilestonesUseCase;

  MilestoneContractorBloc({required this.getMilestonesUseCase})
    : super(MilestoneContractorInitial()) {
    on<LoadMilestoneContractorData>((event, emit) async {
      emit(MilestoneContractorLoading());
      try {
        final milestones = await getMilestonesUseCase();
        emit(MilestoneContractorLoaded(milestones: milestones));
      } catch (e) {
        emit(MilestoneContractorError(message: e.toString()));
      }
    });
  }
}
