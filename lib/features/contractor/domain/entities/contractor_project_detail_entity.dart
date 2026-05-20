import 'package:buildmatch_mobile/features/contractor/domain/entities/contractor_project_request_entity.dart';

class ContractorProjectDetailEntity extends ContractorProjectRequestEntity {
  final String buildingHeight;
  final String startDate;
  final String endDate;
  final String budgetMin;
  final String budgetMax;
  final String description;
  final List<ContractorProjectFile> files;
  final int bidCount;
  final String avgBid;
  final String avgWorkDays;
  final ContractorProjectClient client;

  const ContractorProjectDetailEntity({
    required super.id,
    required super.title,
    required super.category,
    required super.location,
    required super.city,
    required super.priceMin,
    required super.priceMax,
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

class ContractorProjectFile {
  final String name;
  final String type;
  final String size;

  const ContractorProjectFile({
    required this.name,
    required this.type,
    required this.size,
  });
}

class ContractorProjectClient {
  final String name;
  final String avatarColor;
  final bool isVerified;
  final String location;

  const ContractorProjectClient({
    required this.name,
    required this.avatarColor,
    this.isVerified = false,
    required this.location,
  });
}
