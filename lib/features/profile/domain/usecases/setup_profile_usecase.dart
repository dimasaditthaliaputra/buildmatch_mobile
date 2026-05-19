import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class SetupProfileUseCase {
  final ProfileRepository repository;

  SetupProfileUseCase(this.repository);

  Future<Either<Failure, void>> call(ProfileEntity profile) {
    return repository.saveProfile(profile);
  }
}
