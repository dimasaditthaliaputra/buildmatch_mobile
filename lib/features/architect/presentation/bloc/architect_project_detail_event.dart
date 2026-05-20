abstract class ArchitectProjectDetailEvent {}

class LoadArchitectProjectDetail extends ArchitectProjectDetailEvent {
  final String projectId;
  LoadArchitectProjectDetail(this.projectId);
}
