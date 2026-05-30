import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/contractor_project_request_entity.dart';
import '../../domain/usecases/get_contractor_project_requests.dart';
import 'contractor_project_request_event.dart';
import 'contractor_project_request_state.dart';

class ContractorProjectRequestBloc extends Bloc<ContractorProjectRequestEvent, ContractorProjectRequestState> {
  final GetContractorProjectRequests getContractorProjectRequests;

  ContractorProjectRequestBloc(this.getContractorProjectRequests) : super(const ContractorProjectRequestState()) {
    on<LoadContractorProjectRequests>((event, emit) async {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(const Duration(milliseconds: 1500));
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

    on<SearchContractorProjectRequests>((event, emit) {
      final query = event.query.toLowerCase();
      final filtered = state.allRequests.where((r) {
        final matchesStatus = r.status == state.selectedStatus;
        final matchesQuery = r.title.toLowerCase().contains(query) ||
            r.category.toLowerCase().contains(query) ||
            r.city.toLowerCase().contains(query) ||
            r.location.toLowerCase().contains(query);
        return matchesStatus && matchesQuery;
      }).toList();
      emit(state.copyWith(filteredRequests: filtered));
    });

    on<ApplyContractorProjectFilter>((event, emit) {
      final filtered = state.allRequests.where((r) {
        if (r.status != state.selectedStatus) return false;

        final minPrice = _parsePriceToRupiah(r.priceMin);
        final maxPrice = _parsePriceToRupiah(r.priceMax);

        if (event.minBudget != null && maxPrice < event.minBudget!) {
          return false;
        }
        if (event.maxBudget != null && minPrice > event.maxBudget!) {
          return false;
        }

        if (event.location.isNotEmpty) {
          final query = event.location.toLowerCase();
          final matchesLocation = r.location.toLowerCase().contains(query) ||
              r.city.toLowerCase().contains(query);
          if (!matchesLocation) return false;
        }

        return true;
      }).toList();

      if (event.sortOption == 'Budget Tertinggi') {
        filtered.sort((a, b) {
          final bMax = _parsePriceToRupiah(b.priceMax);
          final aMax = _parsePriceToRupiah(a.priceMax);
          return bMax.compareTo(aMax);
        });
      } else if (event.sortOption == 'Terbaru') {
        filtered.sort((a, b) {
          if (a.isNew && !b.isNew) return -1;
          if (!a.isNew && b.isNew) return 1;
          return 0;
        });
      }

      emit(state.copyWith(filteredRequests: filtered));
    });
  }

  int _parsePriceToRupiah(String priceStr) {
    final cleaned = priceStr.replaceAll(RegExp(r'\D'), '');
    final val = int.tryParse(cleaned) ?? 0;
    if (val == 0) return 0;
    if (val < 100000) {
      return val * 1000000;
    }
    return val;
  }
}