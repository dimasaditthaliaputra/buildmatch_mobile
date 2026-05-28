import 'package:equatable/equatable.dart';

abstract class ProjectOffersEvent extends Equatable {
  const ProjectOffersEvent();

  @override
  List<Object?> get props => [];
}

class LoadProjectOffers extends ProjectOffersEvent {
  final String projectId;

  const LoadProjectOffers({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class SearchProjectOffers extends ProjectOffersEvent {
  final String query;

  const SearchProjectOffers({required this.query});

  @override
  List<Object?> get props => [query];
}
