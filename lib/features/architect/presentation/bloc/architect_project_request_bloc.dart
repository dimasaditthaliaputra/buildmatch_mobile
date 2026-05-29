import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/architect_project_request_entity.dart';
import '../../domain/usecases/get_architect_project_requests.dart';
import 'architect_project_request_event.dart';
import 'architect_project_request_state.dart';

class ArchitectProjectRequestBloc extends Bloc<ArchitectProjectRequestEvent, ArchitectProjectRequestState> {
  final GetArchitectProjectRequests getArchitectProjectRequests;

  ArchitectProjectRequestBloc(this.getArchitectProjectRequests) : super(const ArchitectProjectRequestState()) {
    on<LoadArchitectProjectRequests>((event, emit) {
      emit(state.copyWith(isLoading: true));
      final requests = getArchitectProjectRequests.execute();
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

    on<FilterArchitectProjectRequestsByStatus>((event, emit) {
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