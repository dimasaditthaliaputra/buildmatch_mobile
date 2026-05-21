import '../entities/contractor_milestone_entity.dart';
import '../repositories/contractor_milestone_repository.dart';

class ContractorGetSystemMilestonesUseCase {
  final ContractorMilestoneRepository repository;
  ContractorGetSystemMilestonesUseCase(this.repository);

  Future<List<ContractorMilestoneEntity>> call(double totalNilaiKontrak) {
    return repository.getSystemMilestones(totalNilaiKontrak);
  }
}
