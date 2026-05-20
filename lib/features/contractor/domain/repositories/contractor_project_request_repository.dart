import '../entities/contractor_project_request_entity.dart';

abstract class ContractorProjectRequestRepository {
  List<ContractorProjectRequestEntity> getContractorProjectRequests();
}