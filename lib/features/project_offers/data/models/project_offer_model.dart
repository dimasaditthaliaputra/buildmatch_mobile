import '../../domain/entities/project_offer_entity.dart';

class ProjectOfferModel extends ProjectOfferEntity {
  const ProjectOfferModel({
    required super.id,
    required super.name,
    required super.avatarUrl,
    required super.role,
    required super.rating,
    required super.reviewsCount,
    required super.price,
    required super.estimatedDays,
    required super.message,
  });

  factory ProjectOfferModel.fromJson(Map<String, dynamic> json) {
    return ProjectOfferModel(
      id: json['id'],
      name: json['name'],
      avatarUrl: json['avatarUrl'],
      role: json['role'] == 'architect'
          ? ProjectOfferRole.architect
          : ProjectOfferRole.contractor,
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'],
      price: (json['price'] as num).toDouble(),
      estimatedDays: json['estimatedDays'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'role': role == ProjectOfferRole.architect ? 'architect' : 'contractor',
      'rating': rating,
      'reviewsCount': reviewsCount,
      'price': price,
      'estimatedDays': estimatedDays,
      'message': message,
    };
  }
}
