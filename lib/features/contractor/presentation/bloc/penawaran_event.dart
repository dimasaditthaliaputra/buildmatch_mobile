part of 'penawaran_bloc.dart';

abstract class PenawaranEvent extends Equatable {
  const PenawaranEvent();

  @override
  List<Object?> get props => [];
}

class BudgetMinChanged extends PenawaranEvent {
  final int value;
  const BudgetMinChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class BudgetMaxChanged extends PenawaranEvent {
  final int value;
  const BudgetMaxChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PesanChanged extends PenawaranEvent {
  final String value;
  const PesanChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class EstimasiWaktuChanged extends PenawaranEvent {
  final DateTime value;
  const EstimasiWaktuChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PenawaranSubmitted extends PenawaranEvent {
  final String projectId;
  const PenawaranSubmitted({required this.projectId});

  @override
  List<Object?> get props => [projectId];
}

class PenawaranReset extends PenawaranEvent {
  const PenawaranReset();
}