import 'package:buildmatch_mobile/features/architect/data/datasources/architect_project_detail_local_data_source.dart';

import '../../domain/entities/Architect_project_detail_entity.dart';
import '../../domain/repositories/Architect_project_detail_repository.dart';

class ArchitectProjectDetailRepositoryImpl
    implements ArchitectProjectDetailRepository {
  final ArchitectProjectDetailLocalDataSource localDataSource;

  ArchitectProjectDetailRepositoryImpl(this.localDataSource);

  ArchitectProjectDetailEntity getArchitectProjectDetail(String id) {
    return localDataSource.getArchitectProjectDetail(id);
  }

  @override
  ArchitectProjectDetailEntity getProjectDetail(String id) {
    return localDataSource.getArchitectProjectDetail(id);
  }
}
