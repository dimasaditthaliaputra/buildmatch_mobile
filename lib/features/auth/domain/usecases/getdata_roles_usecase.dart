import 'package:buildmatch_mobile/features/auth/domain/entities/roles_entity.dart';
import 'package:buildmatch_mobile/features/auth/domain/repositories/roles_repository.dart';

class GetRolesDataUseCase {
  final RolesRepository repository;

  GetRolesDataUseCase(this.repository);

  List<RolesEntity> call() {
    return repository.getData();
  }
}