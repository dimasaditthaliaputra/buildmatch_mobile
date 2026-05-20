import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/verification_status.dart';
import '../repositories/waiting_approval_repository.dart';

class GetVerificationStatusUseCase {
  final WaitingApprovalRepository repository;

  GetVerificationStatusUseCase(this.repository);

  Future<Either<Failure, VerificationStatus>> call() async {
    return await repository.getVerificationStatus();
  }
}
