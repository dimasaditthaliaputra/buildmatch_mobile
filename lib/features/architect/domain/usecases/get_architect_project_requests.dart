import '../entities/architect_project_request_entity.dart';
import '../repositories/architect_project_request_repository.dart';

class GetArchitectProjectRequests {
  final ArchitectProjectRequestRepository repository;

  GetArchitectProjectRequests(this.repository);

  List<ArchitectProjectRequestEntity> execute() {
    return repository.getArchitectProjectRequests();
  }
}