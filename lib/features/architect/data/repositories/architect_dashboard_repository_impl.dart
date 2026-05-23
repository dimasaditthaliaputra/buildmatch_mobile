import '../../domain/entities/architect_dashboard_entity.dart';
import '../../domain/repositories/architect_dashboard_repository.dart';
import '../datasources/architect_dashboard_remote_datasource.dart';

class ArchitectDashboardRepositoryImpl
    implements ArchitectDashboardRepository {
  final ArchitectDashboardRemoteDataSource remoteDataSource;

  ArchitectDashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ArchitectDashboardEntity> getDashboardData(
    String architectId,
  ) async {
    final result = await remoteDataSource.getDashboardData(architectId);
    return result;
  }
}