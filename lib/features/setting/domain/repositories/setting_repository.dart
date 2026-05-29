import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/setting_user_entity.dart';

abstract class SettingRepository {
  /// Fetches the current logged-in user's profile data.
  Future<Either<Failure, SettingUserEntity>> getUserProfile();

  /// Updates the current user's profile fields.
  Future<Either<Failure, SettingUserEntity>> updateUserProfile({
    String? fullName,
    String? phoneNumber,
    String? address,
  });
}
