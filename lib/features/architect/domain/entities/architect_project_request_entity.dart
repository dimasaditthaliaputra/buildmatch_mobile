enum ProjectRequestStatus { offering, ongoing }

class ArchitectProjectRequestEntity {
  final String id;
  final String title;
  final String category; 
  final String location;
  final String city;
  final String priceMin;
  final String priceMax;
  final String buildingArea;
  final String imageUrl;
  final bool isNew;
  final ProjectRequestStatus status;

  const ArchitectProjectRequestEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.city,
    required this.priceMin,
    required this.priceMax,
    required this.buildingArea,
    required this.imageUrl,
    this.isNew = false,
    this.status = ProjectRequestStatus.offering,
  });
}