import '../../domain/entities/architect_dashboard_entity.dart';
import '../../data/repositories/architect_dashboard_repository.dart';
import '../../data/datasources/architect_dashboard_remote_datasource.dart';

class ArchitectDashboardRepositoryImpl
    implements ArchitectDashboardRepository {
  final ArchitectDashboardRemoteDataSource remoteDataSource;

  ArchitectDashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ArchitectDashboardEntity> getDashboardData(
    String contractorId,
  ) async {
    final result = await remoteDataSource.getDashboardData(contractorId);
    return result;
  }
}