import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/contractor_project_list_entity.dart';
import '../../domain/repositories/contractor_project_list_repository.dart';
import '../datasources/contractor_project_list_datasource.dart';

class ContractorProjectListRepositoryImpl implements ContractorProjectListRepository {
  final ContractorProjectListRemoteDataSource remoteDataSource;
  ContractorProjectListRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ContractorProjectListEntity>>> getProjects() async {
  try {
    final projects = await remoteDataSource.getProjects();
    return Right<Failure, List<ContractorProjectListEntity>>(projects);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    return Left(ServerFailure('Gagal memuat data: ${e.toString()}'));
  }
}

  @override
  Future<Either<Failure, List<ContractorProjectListEntity>>> getProjectsByStatus(
    ProjectStatus status,
  ) async {
    try {
      final projects = await remoteDataSource.getProjectsByStatus(status);
      return Right<Failure, List<ContractorProjectListEntity>>(projects);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Gagal memuat data: ${e.toString()}'));
    }
  }
}