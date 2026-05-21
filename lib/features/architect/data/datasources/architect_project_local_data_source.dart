

import 'package:buildmatch_mobile/features/architect/domain/entities/architect_project_entity.dart';

class ProjectModel extends ArchitectProjectEntity {
  const ProjectModel({
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
  });

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      city: json['city'] as String,
      rentPriceMin: json['rent_price_min'] as String,
      rentPriceMax: json['rent_price_max'] as String,
      buildingArea: json['building_area'] as String,
      imageUrl: json['image_url'] as String,
      isNew: json['is_new'] as bool? ?? false,
      status: json['status'] == 'ongoing'
          ? ProjectStatus.ongoing
          : ProjectStatus.offering,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'city': city,
      'rent_price_min': rentPriceMin,
      'rent_price_max': rentPriceMax,
      'building_area': buildingArea,
      'image_url': imageUrl,
      'is_new': isNew,
      'status': status == ProjectStatus.ongoing ? 'ongoing' : 'offering',
    };
  }
}
