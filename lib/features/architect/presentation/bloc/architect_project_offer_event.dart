part of 'architect_project_offer_bloc.dart';

abstract class ArchitectProjectOfferEvent extends Equatable {
  const ArchitectProjectOfferEvent();

  @override
  List<Object?> get props => [];
}

class BudgetMinChanged extends ArchitectProjectOfferEvent {
  final int value;
  const BudgetMinChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class BudgetMaxChanged extends ArchitectProjectOfferEvent {
  final int value;
  const BudgetMaxChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PesanChanged extends ArchitectProjectOfferEvent {
  final String value;
  const PesanChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class EstimasiWaktuChanged extends ArchitectProjectOfferEvent {
  final DateTime value;
  const EstimasiWaktuChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PenawaranSubmitted extends ArchitectProjectOfferEvent {
  final String projectId;
  const PenawaranSubmitted({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class PenawaranReset extends ArchitectProjectOfferEvent {
  const PenawaranReset();
}