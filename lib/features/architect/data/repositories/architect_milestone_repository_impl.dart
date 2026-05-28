import '../../domain/entities/architect_milestone_entity.dart';
import '../../domain/repositories/architect_milestone_repository.dart';
import '../datasources/architect_milestone_local_data_source.dart';

class ArchitectMilestoneRepositoryImpl implements ArchitectMilestoneRepository {
  final ArchitectMilestoneLocalDataSource localDataSource;

  ArchitectMilestoneRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ArchitectMilestoneEntity>> getSystemMilestones(
      double totalNilaiKontrak) async {
    return localDataSource.getSystemMilestones(totalNilaiKontrak);
  }

  @override
  Future<void> publikasiMilestone(
      List<ArchitectMilestoneEntity> milestones) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Implement remote API call
  }
}
