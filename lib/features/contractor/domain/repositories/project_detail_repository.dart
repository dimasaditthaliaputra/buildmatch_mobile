import '../entities/project_detail_entity.dart';

abstract class ProjectDetailRepository {
  ProjectDetailEntity getProjectDetail(String id);
}
