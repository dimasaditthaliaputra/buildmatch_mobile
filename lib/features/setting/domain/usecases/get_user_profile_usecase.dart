import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/setting_user_entity.dart';
import '../repositories/setting_repository.dart';

class GetUserProfileUseCase {
  final SettingRepository repository;

  const GetUserProfileUseCase(this.repository);

  Future<Either<Failure, SettingUserEntity>> call() {
    return repository.getUserProfile();
  }
}
