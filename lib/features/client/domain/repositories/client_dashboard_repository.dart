import '../entities/client_dashboard_entity.dart';

abstract class ClientDashboardRepository {
  Future<ClientDashboardEntity> getDashboardData(String clientId);
}
