import 'package:equatable/equatable.dart';
import '../../domain/entities/architect_milestone_entity.dart';

abstract class ArchitectMilestoneState extends Equatable {
  const ArchitectMilestoneState();

  @override
  List<Object?> get props => [];
}

class ArchitectMilestoneInitial extends ArchitectMilestoneState {
  const ArchitectMilestoneInitial();
}

class ArchitectMilestoneLoading extends ArchitectMilestoneState {
  const ArchitectMilestoneLoading();
}

class ArchitectMilestoneLoaded extends ArchitectMilestoneState {
  final MilestoneInputMode inputMode;
  final List<ArchitectMilestoneEntity> milestones;
  final double totalNilaiKontrak;

  const ArchitectMilestoneLoaded({
    required this.inputMode,
    required this.milestones,
    required this.totalNilaiKontrak,
  });

  /// 0.0 – 1.0
  double get totalAlokasi =>
      milestones.fold(0.0, (sum, m) => sum + m.persentase);

  bool get canPublish => milestones.isNotEmpty;

  ArchitectMilestoneLoaded copyWith({
    MilestoneInputMode? inputMode,
    List<ArchitectMilestoneEntity>? milestones,
    double? totalNilaiKontrak,
  }) {
    return ArchitectMilestoneLoaded(
      inputMode: inputMode ?? this.inputMode,
      milestones: milestones ?? this.milestones,
      totalNilaiKontrak: totalNilaiKontrak ?? this.totalNilaiKontrak,
    );
  }

  @override
  List<Object?> get props => [inputMode, milestones, totalNilaiKontrak];
}

class ArchitectMilestonePublishing extends ArchitectMilestoneState {
  const ArchitectMilestonePublishing();
}

class ArchitectMilestonePublishSuccess extends ArchitectMilestoneState {
  const ArchitectMilestonePublishSuccess();
}

class ArchitectMilestoneError extends ArchitectMilestoneState {
  final String message;
  const ArchitectMilestoneError(this.message);

  @override
  List<Object?> get props => [message];
}
