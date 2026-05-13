import '../../domain/entities/contractor_dashboard_entity.dart';
import '../../domain/repositories/contractor_dashboard_repository.dart';
import '../datasources/contractor_dashboard_remote_datasource.dart';

class ContractorDashboardRepositoryImpl
    implements ContractorDashboardRepository {
  final ContractorDashboardRemoteDataSource remoteDataSource;

  ContractorDashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<ContractorDashboardEntity> getDashboardData(
    String contractorId,
  ) async {
    final result = await remoteDataSource.getDashboardData(contractorId);
    return result;
  }
}