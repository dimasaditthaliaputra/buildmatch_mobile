import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contractor_project_list_entity.dart';
import '../repositories/contractor_project_list_repository.dart';

class GetProjectsByStatus {
  final ContractorProjectListRepository repository;

  GetProjectsByStatus(this.repository);

  Future<Either<Failure, List<ContractorProjectListEntity>>> call(ProjectStatus status) {
    return repository.getProjectsByStatus(status);
  }
}
