import 'architect_project_entity.dart';

class ArchitectProjectDetailEntity extends ArchitectProjectEntity {
  final String buildingHeight;
  final String startDate;
  final String endDate;
  final String budgetMin;
  final String budgetMax;
  final String description;
  final List<ProjectFile> files;
  final int bidCount;
  final String avgBid;
  final String avgWorkDays;
  final ProjectClient client;

  const ArchitectProjectDetailEntity({
    required super.id,
    required super.title,
    required super.category,
    required super.location,
    required super.city,
    required super.rentPriceMin,
    required super.rentPriceMax,
    required super.buildingArea,
    required super.imageUrl,
    super.isNew,
    super.status,
    required this.buildingHeight,
    required this.startDate,
    required this.endDate,
    required this.budgetMin,
    required this.budgetMax,
    required this.description,
    this.files = const [],
    this.bidCount = 0,
    this.avgBid = '',
    this.avgWorkDays = '',
    required this.client,
  });
}

class ProjectFile {
  final String name;
  final String type;
  final String size;

  const ProjectFile({
    required this.name,
    required this.type,
    required this.size,
  });
}

class ProjectClient {
  final String name;
  final String avatarColor;
  final bool isVerified;
  final String location;

  const ProjectClient({
    required this.name,
    required this.avatarColor,
    this.isVerified = false,
    required this.location,
  });
}
