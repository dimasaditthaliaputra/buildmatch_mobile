import '../entities/client_project_entity.dart';

abstract class ClientProjectRepository {
  Future<List<ClientProjectEntity>> getPenawaranProjects(String clientId);
  Future<List<ClientProjectEntity>> getAllProjects(String clientId);
}
