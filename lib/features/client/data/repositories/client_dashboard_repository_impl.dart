import '../../domain/entities/client_dashboard_entity.dart';
import '../../domain/repositories/client_dashboard_repository.dart';
import '../datasources/client_dashboard_local_data_source.dart';

class ClientDashboardRepositoryImpl implements ClientDashboardRepository {
  final ClientDashboardLocalDataSource localDataSource;

  ClientDashboardRepositoryImpl({required this.localDataSource});

  @override
  Future<ClientDashboardEntity> getDashboardData(String clientId) async {
    return await localDataSource.getDashboardData(clientId);
  }
}
