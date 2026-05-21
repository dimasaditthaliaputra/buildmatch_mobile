import '../entities/Architect_project_detail_entity.dart';
import '../repositories/Architect_project_detail_repository.dart';

class GetArchitectProjectDetail {
  final ArchitectProjectDetailRepository repository;

  GetArchitectProjectDetail(this.repository);

  ArchitectProjectDetailEntity execute(String id) {
    return repository.getProjectDetail(id);
  }
}
