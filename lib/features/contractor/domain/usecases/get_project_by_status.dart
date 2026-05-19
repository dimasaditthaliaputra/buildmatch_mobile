import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/project_contractor_list_entity.dart';
import '../repositories/project_contractor_list_repository.dart';

class GetProjectsByStatus {
  final ProjectContractorListRepository repository;

  GetProjectsByStatus(this.repository);

  Future<Either<Failure, List<ProjectContractorListEntity>>> call(ProjectStatus status) {
    return repository.getProjectsByStatus(status);
  }
}
