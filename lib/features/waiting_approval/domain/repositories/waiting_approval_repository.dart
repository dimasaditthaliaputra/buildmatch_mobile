import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/verification_status.dart';

abstract class WaitingApprovalRepository {
  Future<Either<Failure, VerificationStatus>> getVerificationStatus();
}
