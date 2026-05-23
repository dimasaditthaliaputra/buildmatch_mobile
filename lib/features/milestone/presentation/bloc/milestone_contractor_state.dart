import 'package:equatable/equatable.dart';
import '../../domain/entities/milestone_entity.dart';

abstract class MilestoneContractorState extends Equatable {
  const MilestoneContractorState();

  @override
  List<Object> get props => [];
}

class MilestoneContractorInitial extends MilestoneContractorState {}

class MilestoneContractorLoading extends MilestoneContractorState {}

class MilestoneContractorLoaded extends MilestoneContractorState {
  final List<MilestoneEntity> milestones;

  const MilestoneContractorLoaded({required this.milestones});

  @override
  List<Object> get props => [milestones];
}

class MilestoneContractorError extends MilestoneContractorState {
  final String message;

  const MilestoneContractorError({required this.message});

  @override
  List<Object> get props => [message];
}
