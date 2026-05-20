import '../entities/client_project_entity.dart';
import '../repositories/client_project_repository.dart';

class GetClientPenawaranUseCase {
  final ClientProjectRepository repository;

  GetClientPenawaranUseCase({required this.repository});

  Future<List<ClientProjectEntity>> call(String clientId) {
    return repository.getPenawaranProjects(clientId);
  }
}

class GetClientAllProjectsUseCase {
  final ClientProjectRepository repository;

  GetClientAllProjectsUseCase({required this.repository});

  Future<List<ClientProjectEntity>> call(String clientId) {
    return repository.getAllProjects(clientId);
  }
}
