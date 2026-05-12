import '../entities/project_entity.dart';

abstract class ProjectRepository {
  List<ProjectEntity> getProjects();
}
