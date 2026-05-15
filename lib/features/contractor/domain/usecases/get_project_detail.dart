import '../entities/project_detail_entity.dart';
import '../repositories/project_detail_repository.dart';

class GetProjectDetail {
  final ProjectDetailRepository repository;

  GetProjectDetail(this.repository);

  ProjectDetailEntity execute(String id) {
    return repository.getProjectDetail(id);
  }
}
