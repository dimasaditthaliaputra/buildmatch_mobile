import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/setting_user_entity.dart';
import '../repositories/setting_repository.dart';

class UpdateUserProfileUseCase {
  final SettingRepository repository;

  const UpdateUserProfileUseCase(this.repository);

  Future<Either<Failure, SettingUserEntity>> call({
    String? fullName,
    String? phoneNumber,
    String? address,
  }) {
    return repository.updateUserProfile(
      fullName: fullName,
      phoneNumber: phoneNumber,
      address: address,
    );
  }
}
