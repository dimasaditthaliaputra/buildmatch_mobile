import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/user_entity.dart';
import '../entities/roles_entity.dart';

abstract class RolesRepository {
  List<RolesEntity> getData();
}