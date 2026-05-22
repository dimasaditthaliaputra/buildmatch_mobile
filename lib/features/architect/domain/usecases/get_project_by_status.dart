import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/architect_project_list_entity.dart';
import '../repositories/architect_project_list_repository.dart';

class GetArchitectProjectsByStatus {
  final ArchitectProjectListRepository repository;

  GetArchitectProjectsByStatus(this.repository);

  Future<Either<Failure, List<ArchitectProjectListEntity>>> call(ProjectStatus status) {
    return repository.getProjectsByStatus(status);
  }
}
