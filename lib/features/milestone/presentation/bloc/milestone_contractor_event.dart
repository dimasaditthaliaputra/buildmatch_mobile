import 'package:equatable/equatable.dart';

abstract class MilestoneContractorEvent extends Equatable {
  const MilestoneContractorEvent();

  @override
  List<Object> get props => [];
}

class LoadMilestoneContractorData extends MilestoneContractorEvent {}
