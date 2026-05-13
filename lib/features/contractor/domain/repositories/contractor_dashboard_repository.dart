import '../entities/contractor_dashboard_entity.dart';

abstract class ContractorDashboardRepository {
  Future<ContractorDashboardEntity> getDashboardData(String contractorId);
}