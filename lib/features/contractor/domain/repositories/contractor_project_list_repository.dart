import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contractor_project_list_entity.dart';

abstract class ContractorProjectListRepository {
   Future<Either<Failure, List<ContractorProjectListEntity>>> getProjects();
  Future<Either<Failure, List<ContractorProjectListEntity>>> getProjectsByStatus(
    ProjectStatus status,
  );
}
