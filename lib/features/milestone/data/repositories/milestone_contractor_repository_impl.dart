import '../../domain/entities/milestone_entity.dart';
import '../../domain/repositories/milestone_contractor_repository.dart';
import '../datasources/milestone_contractor_local_data_source.dart';

class MilestoneContractorRepositoryImpl implements MilestoneContractorRepository {
  final MilestoneContractorLocalDataSource localDataSource;

  MilestoneContractorRepositoryImpl({required this.localDataSource});

  @override
  Future<List<MilestoneEntity>> getMilestones({String? projectId}) async {
    try {
      final milestoneModels = await localDataSource.getMilestones(projectId: projectId);
      // Since MilestoneModel extends MilestoneEntity, we can just return it as List<MilestoneEntity>
      return milestoneModels;
    } catch (e) {
      throw Exception('Gagal mendapatkan data milestone: $e');
    }
  }
}
