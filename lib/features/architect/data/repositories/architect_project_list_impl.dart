import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/architect_project_list_entity.dart';
import '../../domain/repositories/architect_project_list_repository.dart';
import '../datasources/architect_project_list_datasource.dart';

class ArchitectProjectListRepositoryImpl implements ArchitectProjectListRepository {
  final ArchitectProjectListRemoteDataSource remoteDataSource;
  ArchitectProjectListRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ArchitectProjectListEntity>>> getProjects() async {
  try {
    final projects = await remoteDataSource.getProjects();
    return Right<Failure, List<ArchitectProjectListEntity>>(projects);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    return Left(ServerFailure('Gagal memuat data: ${e.toString()}'));
  }
}

  @override
  Future<Either<Failure, List<ArchitectProjectListEntity>>> getProjectsByStatus(
    ProjectStatus status,
  ) async {
    try {
      final projects = await remoteDataSource.getProjectsByStatus(status);
      return Right<Failure, List<ArchitectProjectListEntity>>(projects);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Gagal memuat data: ${e.toString()}'));
    }
  }
}