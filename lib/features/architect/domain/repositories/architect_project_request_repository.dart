import '../entities/architect_project_request_entity.dart';

abstract class ArchitectProjectRequestRepository {
  List<ArchitectProjectRequestEntity> getArchitectProjectRequests();
}