import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contractor_project_list_entity.dart';
import '../repositories/contractor_project_list_repository.dart';

class GetAllProjects {
  final ContractorProjectListRepository repository;

  GetAllProjects(this.repository);

  Future<Either<Failure, List<ContractorProjectListEntity>>> call() {
    return repository.getProjects();
  }
}
