import '../entities/architect_dashboard_entity.dart';
import '../repositories/architect_dashboard_repository.dart';

class GetArchitectDashboardUseCase {
  final ArchitectDashboardRepository repository;

  GetArchitectDashboardUseCase({required this.repository});

  Future<ArchitectDashboardEntity> call(String architectId) async {
    return await repository.getDashboardData(architectId);
  }
}