import '../../domain/entities/project_detail_entity.dart';
import '../../domain/repositories/project_detail_repository.dart';
import '../datasources/project_detail_local_data_source.dart';

class ProjectDetailRepositoryImpl implements ProjectDetailRepository {
  final ContractorProjectRequestDetailLocalDataSourceImpl localDataSource;

  ProjectDetailRepositoryImpl(this.localDataSource);

  @override
  ProjectDetailEntity getProjectDetail(String id) {
    return localDataSource.getProjectRequestDetail(id);
  }
}
