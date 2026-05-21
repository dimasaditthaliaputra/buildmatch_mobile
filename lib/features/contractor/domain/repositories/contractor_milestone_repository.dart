import '../entities/contractor_milestone_entity.dart';

abstract class ContractorMilestoneRepository {
  Future<List<ContractorMilestoneEntity>> getSystemMilestones(double totalNilaiKontrak);
  Future<void> publikasiMilestone(List<ContractorMilestoneEntity> milestones);
}
