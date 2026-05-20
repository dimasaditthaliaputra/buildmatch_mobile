import '../../domain/entities/client_project_entity.dart';
import '../../domain/repositories/client_project_repository.dart';
import '../datasources/client_project_local_data_source.dart';

class ClientProjectRepositoryImpl implements ClientProjectRepository {
  final ClientProjectLocalDataSource localDataSource;

  ClientProjectRepositoryImpl({required this.localDataSource});

  @override
  Future<List<ClientProjectEntity>> getPenawaranProjects(
      String clientId) async {
    return await localDataSource.getPenawaranProjects(clientId);
  }

  @override
  Future<List<ClientProjectEntity>> getAllProjects(String clientId) async {
    return await localDataSource.getAllProjects(clientId);
  }
}
