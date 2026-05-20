import '../../domain/entities/contractor_project_request_entity.dart';

class ContractorProjectRequestModel extends ContractorProjectRequestEntity {
  const ContractorProjectRequestModel({
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
  });

  factory ContractorProjectRequestModel.fromJson(Map<String, dynamic> json) {
    return ContractorProjectRequestModel(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      city: json['city'] as String,
      priceMin: json['price_min'] as String,
      priceMax: json['price_max'] as String,
      buildingArea: json['building_area'] as String,
      imageUrl: json['image_url'] as String,
      isNew: json['is_new'] as bool? ?? false,
      status: _parseStatus(json['status'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'location': location,
      'city': city,
      'price_min': priceMin,
      'price_max': priceMax,
      'building_area': buildingArea,
      'image_url': imageUrl,
      'is_new': isNew,
      'status': status.name,
    };
  }

  static ProjectRequestStatus _parseStatus(String? statusString) {
    if (statusString == null) return ProjectRequestStatus.offering;
    
    switch (statusString.toLowerCase()) {
      case 'ongoing':
        return ProjectRequestStatus.ongoing;
      case 'offering':
      default:
        return ProjectRequestStatus.offering;
    }
  }
}