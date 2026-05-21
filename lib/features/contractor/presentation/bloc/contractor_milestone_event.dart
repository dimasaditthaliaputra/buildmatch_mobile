import 'package:equatable/equatable.dart';
import '../../domain/entities/contractor_milestone_entity.dart';

abstract class ContractorMilestoneEvent extends Equatable {
  const ContractorMilestoneEvent();

  @override
  List<Object?> get props => [];
}

class ContractorMilestoneInputModeChanged extends ContractorMilestoneEvent {
  final MilestoneInputMode mode;
  const ContractorMilestoneInputModeChanged(this.mode);

  @override
  List<Object?> get props => [mode];
}

class ContractorMilestoneLoadSystem extends ContractorMilestoneEvent {
  final double totalNilaiKontrak;
  const ContractorMilestoneLoadSystem(this.totalNilaiKontrak);

  @override
  List<Object?> get props => [totalNilaiKontrak];
}

class ContractorMilestoneAdded extends ContractorMilestoneEvent {
  const ContractorMilestoneAdded();
}

class ContractorMilestoneUpdated extends ContractorMilestoneEvent {
  final ContractorMilestoneEntity milestone;
  const ContractorMilestoneUpdated(this.milestone);

  @override
  List<Object?> get props => [milestone];
}

class ContractorMilestoneDeleted extends ContractorMilestoneEvent {
  final String milestoneId;
  const ContractorMilestoneDeleted(this.milestoneId);

  @override
  List<Object?> get props => [milestoneId];
}

class ContractorMilestoneReordered extends ContractorMilestoneEvent {
  final int oldIndex;
  final int newIndex;
  const ContractorMilestoneReordered({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class ContractorMilestoneSystemDeadlineUpdated extends ContractorMilestoneEvent {
  final String milestoneId;
  final DateTime deadline;
  const ContractorMilestoneSystemDeadlineUpdated({
    required this.milestoneId,
    required this.deadline,
  });

  @override
  List<Object?> get props => [milestoneId, deadline];
}

class ContractorMilestonePublished extends ContractorMilestoneEvent {
  const ContractorMilestonePublished();
}
