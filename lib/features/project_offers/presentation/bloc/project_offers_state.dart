import 'package:equatable/equatable.dart';
import '../../domain/entities/project_offer_entity.dart';

abstract class ProjectOffersState extends Equatable {
  const ProjectOffersState();

  @override
  List<Object?> get props => [];
}

class ProjectOffersInitial extends ProjectOffersState {}

class ProjectOffersLoading extends ProjectOffersState {}

class ProjectOffersLoaded extends ProjectOffersState {
  final List<ProjectOfferEntity> offers;
  final List<ProjectOfferEntity> filteredOffers;
  final String searchQuery;

  const ProjectOffersLoaded({
    required this.offers,
    required this.filteredOffers,
    this.searchQuery = '',
  });

  ProjectOffersLoaded copyWith({
    List<ProjectOfferEntity>? offers,
    List<ProjectOfferEntity>? filteredOffers,
    String? searchQuery,
  }) {
    return ProjectOffersLoaded(
      offers: offers ?? this.offers,
      filteredOffers: filteredOffers ?? this.filteredOffers,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [offers, filteredOffers, searchQuery];
}

class ProjectOffersError extends ProjectOffersState {
  final String message;

  const ProjectOffersError({required this.message});

  @override
  List<Object?> get props => [message];
}
