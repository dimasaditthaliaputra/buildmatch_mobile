import '../entities/architect_milestone_entity.dart';
import '../repositories/architect_milestone_repository.dart';

class ArchitectPublikasiMilestoneUseCase {
  final ArchitectMilestoneRepository repository;
  ArchitectPublikasiMilestoneUseCase(this.repository);

  Future<void> call(List<ArchitectMilestoneEntity> milestones) {
    return repository.publikasiMilestone(milestones);
  }
}
