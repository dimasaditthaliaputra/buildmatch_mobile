abstract class ContractorProjectDetailEvent {}

class LoadContractorProjectDetail extends ContractorProjectDetailEvent {
  final String projectId;
  LoadContractorProjectDetail(this.projectId);
}
