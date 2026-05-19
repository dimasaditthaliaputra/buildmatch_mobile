import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/portofolio_entity.dart';
import '../../domain/repositories/portofolio_repository.dart';
import '../datasources/portofolio_local_data_source.dart';

class PortofolioRepositoryImpl implements PortofolioRepository {
  final PortofolioLocalDataSource localDataSource;

  const PortofolioRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, PortofolioEntity>> tambahPortofolio({
    required String judul,
    required String deskripsi,
    required List<String> imagePaths,
  }) async {
    try {
      final result = await localDataSource.tambahPortofolio({
        'judul': judul,
        'deskripsi': deskripsi,
        'image_paths': imagePaths,
      });

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
