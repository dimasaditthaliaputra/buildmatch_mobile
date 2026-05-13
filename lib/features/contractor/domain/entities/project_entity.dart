class ProjectEntity {
  final String id;
  final String title;
  final String category; // e.g. 'RESIDENSIAL', 'KOMERSIAL'
  final String location;
  final String city;
  final String rentPriceMin;
  final String rentPriceMax;
  final String buildingArea;
  final String imageUrl;
  final bool isNew;
  final ProjectStatus status;

  const ProjectEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.city,
    required this.rentPriceMin,
    required this.rentPriceMax,
    required this.buildingArea,
    required this.imageUrl,
    this.isNew = false,
    this.status = ProjectStatus.offering,
  });
}

enum ProjectStatus { offering, ongoing }
