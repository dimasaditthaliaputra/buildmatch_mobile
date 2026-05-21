import 'package:equatable/equatable.dart';
import '../../domain/entities/contractor_milestone_entity.dart';

abstract class ContractorMilestoneState extends Equatable {
  const ContractorMilestoneState();

  @override
  List<Object?> get props => [];
}

class ContractorMilestoneInitial extends ContractorMilestoneState {
  const ContractorMilestoneInitial();
}

class ContractorMilestoneLoading extends ContractorMilestoneState {
  const ContractorMilestoneLoading();
}

class ContractorMilestoneLoaded extends ContractorMilestoneState {
  final MilestoneInputMode inputMode;
  final List<ContractorMilestoneEntity> milestones;
  final double totalNilaiKontrak;

  const ContractorMilestoneLoaded({
    required this.inputMode,
    required this.milestones,
    required this.totalNilaiKontrak,
  });

  /// 0.0 – 1.0
  double get totalAlokasi =>
      milestones.fold(0.0, (sum, m) => sum + m.persentase);

  bool get canPublish => milestones.isNotEmpty;

  ContractorMilestoneLoaded copyWith({
    MilestoneInputMode? inputMode,
    List<ContractorMilestoneEntity>? milestones,
    double? totalNilaiKontrak,
  }) {
    return ContractorMilestoneLoaded(
      inputMode: inputMode ?? this.inputMode,
      milestones: milestones ?? this.milestones,
      totalNilaiKontrak: totalNilaiKontrak ?? this.totalNilaiKontrak,
    );
  }

  @override
  List<Object?> get props => [inputMode, milestones, totalNilaiKontrak];
}

class ContractorMilestonePublishing extends ContractorMilestoneState {
  const ContractorMilestonePublishing();
}

class ContractorMilestonePublishSuccess extends ContractorMilestoneState {
  const ContractorMilestonePublishSuccess();
}

class ContractorMilestoneError extends ContractorMilestoneState {
  final String message;
  const ContractorMilestoneError(this.message);

  @override
  List<Object?> get props => [message];
}
