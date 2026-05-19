import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class RolesEntity extends Equatable {
  final int id;
  final String rolesName;
  final String title;
  final IconData icon;
  final String description;

  const RolesEntity({
    required this.id,
    required this.rolesName,
    required this.title,
    required this.icon,
    required this.description,
  });

  @override
  List<Object?> get props => [id, rolesName];
}
