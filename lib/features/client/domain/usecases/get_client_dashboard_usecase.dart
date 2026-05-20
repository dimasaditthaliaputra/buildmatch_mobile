import '../entities/client_dashboard_entity.dart';
import '../repositories/client_dashboard_repository.dart';

class GetClientDashboardUseCase {
  final ClientDashboardRepository repository;

  GetClientDashboardUseCase({required this.repository});

  Future<ClientDashboardEntity> call(String clientId) {
    return repository.getDashboardData(clientId);
  }
}
