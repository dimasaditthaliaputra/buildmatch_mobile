import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/contractor_project_offer_entity.dart';
import '../../domain/repositories/contractor_project_offer_repository.dart';
import '../datasources/contractor_project_offer_remote_datasource.dart';

class ContractorProjectOfferRepositoryImpl implements ContractorProjectOfferRepository {
  final ContractorProjectOfferRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const ContractorProjectOfferRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ContractorProjectOfferEntity>> ajukanPenawaran({
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