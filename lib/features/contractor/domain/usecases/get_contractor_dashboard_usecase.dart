import '../entities/contractor_dashboard_entity.dart';
import '../repositories/contractor_dashboard_repository.dart';

class GetContractorDashboardUseCase {
  final ContractorDashboardRepository repository;

  GetContractorDashboardUseCase({required this.repository});

  Future<ContractorDashboardEntity> call(String contractorId) async {
    return await repository.getDashboardData(contractorId);
  }
}