import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/project_contractor_list_entity.dart';
import '../../domain/repositories/project_contractor_list_repository.dart';
import '../datasources/project_contractor_list_datasource.dart';

class ContractorProjectRepositoryImpl implements ProjectContractorListRepository {
  final ContractorProjectRemoteDataSource remoteDataSource;
  ContractorProjectRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ProjectContractorListEntity>>> getProjects() async {
  try {
    final projects = await remoteDataSource.getProjects();
    return Right<Failure, List<ProjectContractorListEntity>>(projects);
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    return Left(ServerFailure('Gagal memuat data: ${e.toString()}'));
  }
}

  @override
  Future<Either<Failure, List<ProjectContractorListEntity>>> getProjectsByStatus(
    ProjectStatus status,
  ) async {
    try {
      final projects = await remoteDataSource.getProjectsByStatus(status);
      return Right<Failure, List<ProjectContractorListEntity>>(projects);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Gagal memuat data: ${e.toString()}'));
    }
  }
}