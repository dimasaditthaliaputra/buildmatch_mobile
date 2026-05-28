import 'package:equatable/equatable.dart';
import '../../domain/entities/architect_milestone_entity.dart';

abstract class ArchitectMilestoneEvent extends Equatable {
  const ArchitectMilestoneEvent();

  @override
  List<Object?> get props => [];
}

class ArchitectMilestoneInputModeChanged extends ArchitectMilestoneEvent {
  final MilestoneInputMode mode;
  const ArchitectMilestoneInputModeChanged(this.mode);

  @override
  List<Object?> get props => [mode];
}

class ArchitectMilestoneLoadSystem extends ArchitectMilestoneEvent {
  final double totalNilaiKontrak;
  const ArchitectMilestoneLoadSystem(this.totalNilaiKontrak);

  @override
  List<Object?> get props => [totalNilaiKontrak];
}

class ArchitectMilestoneAdded extends ArchitectMilestoneEvent {
  const ArchitectMilestoneAdded();
}

class ArchitectMilestoneUpdated extends ArchitectMilestoneEvent {
  final ArchitectMilestoneEntity milestone;
  const ArchitectMilestoneUpdated(this.milestone);

  @override
  List<Object?> get props => [milestone];
}

class ArchitectMilestoneDeleted extends ArchitectMilestoneEvent {
  final String milestoneId;
  const ArchitectMilestoneDeleted(this.milestoneId);

  @override
  List<Object?> get props => [milestoneId];
}

class ArchitectMilestoneReordered extends ArchitectMilestoneEvent {
  final int oldIndex;
  final int newIndex;
  const ArchitectMilestoneReordered({
    required this.oldIndex,
    required this.newIndex,
  });

  @override
  List<Object?> get props => [oldIndex, newIndex];
}

class ArchitectMilestoneSystemDeadlineUpdated extends ArchitectMilestoneEvent {
  final String milestoneId;
  final DateTime deadline;
  const ArchitectMilestoneSystemDeadlineUpdated({
    required this.milestoneId,
    required this.deadline,
  });

  @override
  List<Object?> get props => [milestoneId, deadline];
}

class ArchitectMilestonePublished extends ArchitectMilestoneEvent {
  const ArchitectMilestonePublished();
}
