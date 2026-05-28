import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/datasources/project_offer_local_data_source.dart';
import 'project_offers_event.dart';
import 'project_offers_state.dart';

class ProjectOffersBloc extends Bloc<ProjectOffersEvent, ProjectOffersState> {
  final ProjectOfferLocalDataSource localDataSource;

  ProjectOffersBloc({required this.localDataSource}) : super(ProjectOffersInitial()) {
    on<LoadProjectOffers>(_onLoadProjectOffers);
    on<SearchProjectOffers>(_onSearchProjectOffers);
  }

  Future<void> _onLoadProjectOffers(
    LoadProjectOffers event,
    Emitter<ProjectOffersState> emit,
  ) async {
    emit(ProjectOffersLoading());
    try {
      final offers = await localDataSource.getProjectOffers(event.projectId);
      emit(ProjectOffersLoaded(
        offers: offers,
        filteredOffers: offers,
      ));
    } catch (e) {
      emit(ProjectOffersError(message: e.toString()));
    }
  }

  void _onSearchProjectOffers(
    SearchProjectOffers event,
    Emitter<ProjectOffersState> emit,
  ) {
    final currentState = state;
    if (currentState is ProjectOffersLoaded) {
      final query = event.query.toLowerCase();
      final filtered = query.isEmpty
          ? currentState.offers
          : currentState.offers
              .where((o) =>
                  o.name.toLowerCase().contains(query) ||
                  o.message.toLowerCase().contains(query))
              .toList();

      emit(currentState.copyWith(
        filteredOffers: filtered,
        searchQuery: event.query,
      ));
    }
  }
}
