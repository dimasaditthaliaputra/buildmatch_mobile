import '../entities/Architect_project_detail_entity.dart';

abstract class ArchitectProjectDetailRepository {
  ArchitectProjectDetailEntity getProjectDetail(String id);
}
