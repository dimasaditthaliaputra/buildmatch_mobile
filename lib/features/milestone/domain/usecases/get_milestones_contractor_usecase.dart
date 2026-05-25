import '../entities/milestone_entity.dart';
import '../repositories/milestone_contractor_repository.dart';

class GetMilestonesUseCase {
  final MilestoneContractorRepository repository;

  GetMilestonesUseCase(this.repository);

  Future<List<MilestoneEntity>> call() async {
    return await repository.getMilestones();
  }
}
