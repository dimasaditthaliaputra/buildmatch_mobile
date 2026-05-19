import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/verification_status.dart';
import '../../domain/repositories/waiting_approval_repository.dart';
import '../datasources/waiting_approval_local_data_source.dart';

class WaitingApprovalRepositoryImpl implements WaitingApprovalRepository {
  final WaitingApprovalLocalDataSource localDataSource;

  WaitingApprovalRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, VerificationStatus>> getVerificationStatus() async {
    try {
      final status = await localDataSource.getVerificationStatus();
      return Right(status);
    } on ServerException {
      return const Left(ServerFailure('Gagal mengambil status verifikasi.'));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
