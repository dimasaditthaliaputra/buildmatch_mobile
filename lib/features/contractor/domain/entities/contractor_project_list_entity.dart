enum ProjectStatus { berjalan, selesai }

class ContractorProjectListEntity{
  final String id;
  final String name;
  final String location;
  final DateTime startDate;
  final String clientName;
  final ProjectStatus status;

  const ContractorProjectListEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.startDate,
    required this.clientName,
    required this.status,
  });
}