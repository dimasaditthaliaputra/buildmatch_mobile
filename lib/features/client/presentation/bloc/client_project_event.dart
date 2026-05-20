import 'package:equatable/equatable.dart';

abstract class ClientProjectEvent extends Equatable {
  const ClientProjectEvent();

  @override
  List<Object?> get props => [];
}

class LoadClientPenawaran extends ClientProjectEvent {
  final String clientId;
  const LoadClientPenawaran({required this.clientId});

  @override
  List<Object?> get props => [clientId];
}

class LoadAllClientProjects extends ClientProjectEvent {
  final String clientId;
  const LoadAllClientProjects({required this.clientId});

  @override
  List<Object?> get props => [clientId];
}

class SearchClientProjects extends ClientProjectEvent {
  final String query;
  const SearchClientProjects({required this.query});

  @override
  List<Object?> get props => [query];
}

class SwitchProjectTab extends ClientProjectEvent {
  final int tabIndex; // 0 = Penawaran, 1 = Semua Proyek
  const SwitchProjectTab({required this.tabIndex});

  @override
  List<Object?> get props => [tabIndex];
}
