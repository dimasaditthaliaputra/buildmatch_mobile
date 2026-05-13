import '../../domain/entities/project_entity.dart';

abstract class ProjectEvent {}

class LoadProjects extends ProjectEvent {}

class FilterProjectsByStatus extends ProjectEvent {
  final ProjectStatus status;
  FilterProjectsByStatus(this.status);
}
