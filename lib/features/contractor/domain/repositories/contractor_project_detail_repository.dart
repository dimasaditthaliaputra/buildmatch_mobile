import '../entities/contractor_project_detail_entity.dart';

abstract class ContractorProjectDetailRepository {
  ContractorProjectDetailEntity getProjectDetail(String id);
}
