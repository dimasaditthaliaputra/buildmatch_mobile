import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/contractor_project_request_entity.dart';
import '../../domain/usecases/get_contractor_project_requests.dart';
import 'contractor_project_request_event.dart';
import 'contractor_project_request_state.dart';

class ContractorProjectRequestBloc extends Bloc<ContractorProjectRequestEvent, ContractorProjectRequestState> {
  final GetContractorProjectRequests getContractorProjectRequests;

  ContractorProjectRequestBloc(this.getContractorProjectRequests) : super(const ContractorProjectRequestState()) {
    on<LoadContractorProjectRequests>((event, emit) {
      emit(state.copyWith(isLoading: true));
      final requests = getContractorProjectRequests.execute();
      final filtered = requests
          .where((r) => r.status == ProjectRequestStatus.offering)
          .toList();
      emit(state.copyWith(
        isLoading: false,
        allRequests: requests,
        filteredRequests: filtered,
        selectedStatus: ProjectRequestStatus.offering,
      ));
    });

    on<FilterContractorProjectRequestsByStatus>((event, emit) {
      final filtered = state.allRequests
          .where((r) => r.status == event.status)
          .toList();
      emit(state.copyWith(
        filteredRequests: filtered,
        selectedStatus: event.status,
      ));
    });
  }
}