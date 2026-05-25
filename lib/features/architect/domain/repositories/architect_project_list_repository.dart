import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/architect_project_list_entity.dart';

abstract class ArchitectProjectListRepository {
   Future<Either<Failure, List<ArchitectProjectListEntity>>> getProjects();
  Future<Either<Failure, List<ArchitectProjectListEntity>>> getProjectsByStatus(
    ProjectStatus status,
  );
}
