import '../entities/architect_milestone_entity.dart';

abstract class ArchitectMilestoneRepository {
  Future<List<ArchitectMilestoneEntity>> getSystemMilestones(double totalNilaiKontrak);
  Future<void> publikasiMilestone(List<ArchitectMilestoneEntity> milestones);
}
