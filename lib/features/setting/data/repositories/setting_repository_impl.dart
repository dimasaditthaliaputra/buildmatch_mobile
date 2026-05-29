import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/setting_user_entity.dart';
import '../../domain/repositories/setting_repository.dart';
import '../datasources/setting_remote_data_source.dart';

class SettingRepositoryImpl implements SettingRepository {
  final SettingRemoteDataSource remoteDataSource;

  const SettingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, SettingUserEntity>> getUserProfile() async {
    try {
      final model = await remoteDataSource.getUserProfile();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SettingUserEntity>> updateUserProfile({
    String? fullName,
    String? phoneNumber,
    String? address,
  }) async {
    try {
      final current = await remoteDataSource.getUserProfile();
      final updated = await remoteDataSource.updateUserProfile(
        userId: current.id,
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
      );
      return Right(updated);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
