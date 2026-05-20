import '../entities/contractor_project_request_entity.dart';
import '../repositories/contractor_project_request_repository.dart';

class GetContractorProjectRequests {
  final ContractorProjectRequestRepository repository;

  GetContractorProjectRequests(this.repository);

  List<ContractorProjectRequestEntity> execute() {
    return repository.getContractorProjectRequests();
  }
}