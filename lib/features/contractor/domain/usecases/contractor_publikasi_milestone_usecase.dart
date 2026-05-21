import '../entities/contractor_milestone_entity.dart';
import '../repositories/contractor_milestone_repository.dart';

class ContractorPublikasiMilestoneUseCase {
  final ContractorMilestoneRepository repository;
  ContractorPublikasiMilestoneUseCase(this.repository);

  Future<void> call(List<ContractorMilestoneEntity> milestones) {
    return repository.publikasiMilestone(milestones);
  }
}
