import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/penawaran_entity.dart';
import '../../domain/repositories/penawaran_repository.dart';
import '../datasources/penawaran_remote_datasource.dart';

class PenawaranRepositoryImpl implements PenawaranRepository {
  final PenawaranRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const PenawaranRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, PenawaranEntity>> ajukanPenawaran({
    required String projectId,
    required int budgetMin,
    required int budgetMax,
    required String pesan,
    required DateTime estimasiWaktu,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(
        NetworkFailure('Tidak ada koneksi internet. Periksa jaringan Anda.'),
      );
    }

    try {
      final result = await remoteDataSource.ajukanPenawaran({
        'project_id': projectId,
        'budget_min': budgetMin,
        'budget_max': budgetMax,
        'pesan': pesan,
        'estimasi_waktu': estimasiWaktu.toIso8601String(),
      });

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}