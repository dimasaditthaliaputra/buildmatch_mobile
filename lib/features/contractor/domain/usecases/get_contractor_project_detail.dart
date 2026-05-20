import '../entities/contractor_project_detail_entity.dart';
import '../repositories/contractor_project_detail_repository.dart';

class GetContractorProjectDetail {
  final ContractorProjectDetailRepository repository;

  GetContractorProjectDetail(this.repository);

  ContractorProjectDetailEntity execute(String id) {
    return repository.getProjectDetail(id);
  }
}
