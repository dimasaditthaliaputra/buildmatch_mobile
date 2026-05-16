abstract class ProjectDetailEvent {}

class LoadProjectDetail extends ProjectDetailEvent {
  final String projectId;
  LoadProjectDetail(this.projectId);
}
