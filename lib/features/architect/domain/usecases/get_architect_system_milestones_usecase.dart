import '../entities/architect_milestone_entity.dart';
import '../repositories/architect_milestone_repository.dart';

class ArchitectGetSystemMilestonesUseCase {
  final ArchitectMilestoneRepository repository;
  ArchitectGetSystemMilestonesUseCase(this.repository);

  Future<List<ArchitectMilestoneEntity>> call(double totalNilaiKontrak) {
    return repository.getSystemMilestones(totalNilaiKontrak);
  }
}
