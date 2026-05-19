import '../../domain/entities/project_entity.dart';
import '../../domain/repositories/project_repository.dart';
import '../datasources/project_datasource.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final ProjectLocalDataSource localDataSource;

  ProjectRepositoryImpl(this.localDataSource);

  @override
  List<ProjectEntity> getProjects() {
    return localDataSource.getProjects();
  }
}