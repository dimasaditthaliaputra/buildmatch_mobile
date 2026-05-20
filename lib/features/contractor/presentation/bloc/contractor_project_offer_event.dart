part of 'contractor_project_offer_bloc.dart';

abstract class ContractorProjectOfferEvent extends Equatable {
  const ContractorProjectOfferEvent();

  @override
  List<Object?> get props => [];
}

class BudgetMinChanged extends ContractorProjectOfferEvent {
  final int value;
  const BudgetMinChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class BudgetMaxChanged extends ContractorProjectOfferEvent {
  final int value;
  const BudgetMaxChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PesanChanged extends ContractorProjectOfferEvent {
  final String value;
  const PesanChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class EstimasiWaktuChanged extends ContractorProjectOfferEvent {
  final DateTime value;
  const EstimasiWaktuChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PenawaranSubmitted extends ContractorProjectOfferEvent {
  final String projectId;
  const PenawaranSubmitted({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class PenawaranReset extends ContractorProjectOfferEvent {
  const PenawaranReset();
}