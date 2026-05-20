import '../../domain/entities/contractor_project_detail_entity.dart';
import '../../domain/repositories/contractor_project_detail_repository.dart';
import '../datasources/contractor_project_detail_data_source.dart';

class ContractorProjectDetailRepositoryImpl implements ContractorProjectDetailRepository {
  final ContractorProjectRequestDetailLocalDataSourceImpl localDataSource;

  ContractorProjectDetailRepositoryImpl(this.localDataSource);

  @override
  ContractorProjectDetailEntity getProjectDetail(String id) {
    return localDataSource.getProjectRequestDetail(id);
  }
}
