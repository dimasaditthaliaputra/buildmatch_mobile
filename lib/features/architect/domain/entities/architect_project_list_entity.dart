enum ProjectStatus { berjalan, selesai }

class ArchitectProjectListEntity{
  final String id;
  final String name;
  final String location;
  final DateTime startDate;
  final String clientName;
  final ProjectStatus status;

  const ArchitectProjectListEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.startDate,
    required this.clientName,
    required this.status,
  });
}