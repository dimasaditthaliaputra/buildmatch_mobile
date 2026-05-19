import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/project_contractor_list_entity.dart';

abstract class ProjectContractorListRepository {
   Future<Either<Failure, List<ProjectContractorListEntity>>> getProjects();
  Future<Either<Failure, List<ProjectContractorListEntity>>> getProjectsByStatus(
    ProjectStatus status,
  );
}
