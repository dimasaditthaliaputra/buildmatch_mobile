import 'package:equatable/equatable.dart';
import '../../domain/entities/roles_entity.dart';

abstract class RolesEvent extends Equatable {
  const RolesEvent();

  @override
  List<Object?> get props => [];
}

class GetRolesEvent extends RolesEvent {}

class SelectRoleEvent extends RolesEvent {
  final RolesEntity selectedRole;

  const SelectRoleEvent(this.selectedRole);

  @override
  List<Object?> get props => [selectedRole];
}

class SubmitRoleEvent extends RolesEvent {
  final RolesEntity chosenRole;

  const SubmitRoleEvent(this.chosenRole);

  @override
  List<Object?> get props => [chosenRole];
}
