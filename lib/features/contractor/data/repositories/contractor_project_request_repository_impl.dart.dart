import '../../domain/entities/contractor_project_request_entity.dart';
import '../../domain/repositories/contractor_project_request_repository.dart';
import '../datasources/contractor_project_request_local_datasource.dart';

class ContractorProjectRequestRepositoryImpl implements ContractorProjectRequestRepository {
  final ContractorProjectRequestLocalDataSource localDataSource;

  ContractorProjectRequestRepositoryImpl(this.localDataSource);

  @override
  List<ContractorProjectRequestEntity> getContractorProjectRequests() {
    return localDataSource.getContractorProjectRequests();
  }
}