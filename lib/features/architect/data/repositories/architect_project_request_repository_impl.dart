import '../../domain/entities/architect_project_request_entity.dart';
import '../../domain/repositories/architect_project_request_repository.dart';
import '../datasources/architect_project_request_local_datasource.dart';

class ArchitectProjectRequestRepositoryImpl implements ArchitectProjectRequestRepository {
  final ArchitectProjectRequestLocalDataSource localDataSource;

  ArchitectProjectRequestRepositoryImpl(this.localDataSource);

  @override
  List<ArchitectProjectRequestEntity> getArchitectProjectRequests() {
    return localDataSource.getArchitectProjectRequests();
  }
}