import '../entities/milestone_entity.dart';

abstract class MilestoneContractorRepository {
  Future<List<MilestoneEntity>> getMilestones();
}
