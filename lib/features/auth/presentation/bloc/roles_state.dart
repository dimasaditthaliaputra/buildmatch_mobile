import 'package:equatable/equatable.dart';
import '../../domain/entities/roles_entity.dart';

abstract class RolesState extends Equatable {
  const RolesState();

  @override
  List<Object?> get props => [];
}

class RolesInitial extends RolesState {}

class RolesLoading extends RolesState {}

class RolesLoaded extends RolesState {
  final List<RolesEntity> roles;
  final RolesEntity? selectedRole;

  const RolesLoaded({
    required this.roles,
    this.selectedRole,
  });

  RolesLoaded copyWith({
    List<RolesEntity>? roles,
    RolesEntity? selectedRole,
    bool clearSelection = false,
  }) {
    return RolesLoaded(
      roles: roles ?? this.roles,
      selectedRole: clearSelection ? null : (selectedRole ?? this.selectedRole),
    );
  }

  @override
  List<Object?> get props => [roles, selectedRole];
}

class RolesSubmitting extends RolesState {
  final List<RolesEntity> roles;
  final RolesEntity selectedRole;

  const RolesSubmitting({
    required this.roles,
    required this.selectedRole,
  });

  @override
  List<Object?> get props => [roles, selectedRole];
}

class RolesSubmitSuccess extends RolesState {
  final RolesEntity chosenRole;

  const RolesSubmitSuccess(this.chosenRole);

  @override
  List<Object?> get props => [chosenRole];
}

class RolesFailure extends RolesState {
  final String errorMessage;

  const RolesFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
