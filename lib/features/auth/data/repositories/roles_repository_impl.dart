import '../../domain/entities/roles_entity.dart';
import '../../domain/repositories/roles_repository.dart';
import '../datasources/roles_local_data_source.dart';

class RolesRepositoryImpl implements RolesRepository {
  final RolesLocalDataSource localDataSource;

  RolesRepositoryImpl({required this.localDataSource});

  @override
  List<RolesEntity> getData() {
    return localDataSource.getOnboardingData();
  }
}