import 'package:supabase_flutter/supabase_flutter.dart' show User;
import '../../domain/entities/roles_entity.dart';

class RolesModel extends RolesEntity {
  const RolesModel({
    required super.id,
    required super.rolesName,
    required super.title,
    required super.icon,
    required super.description,
  });
}