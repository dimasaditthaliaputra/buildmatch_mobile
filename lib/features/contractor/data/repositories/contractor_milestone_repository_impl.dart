import '../../domain/entities/contractor_milestone_entity.dart';
import '../../domain/repositories/contractor_milestone_repository.dart';
import '../datasources/contractor_milestone_local_data_source.dart';

class ContractorMilestoneRepositoryImpl implements ContractorMilestoneRepository {
  final ContractorMilestoneLocalDataSource localDataSource;

  ContractorMilestoneRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ContractorMilestoneEntity>> getSystemMilestones(
      double totalNilaiKontrak) async {
    return localDataSource.getSystemMilestones(totalNilaiKontrak);
  }

  @override
  Future<void> publikasiMilestone(
      List<ContractorMilestoneEntity> milestones) async {
    await Future.delayed(const Duration(milliseconds: 500));
    // TODO: Implement remote API call
  }
}
