import '../../domain/entities/rating_client_entity.dart';

class RatingClientModel extends RatingClientEntity {
  const RatingClientModel({
    required super.clientId,
    required super.clientName,
    super.clientImageUrl,
    required super.rating,
    required super.description,
  });

  factory RatingClientModel.fromJson(Map<String, dynamic> json) {
    return RatingClientModel(
      clientId: json['client_id'] as String,
      clientName: json['client_name'] as String,
      clientImageUrl: json['client_image_url'] as String?,
      rating: json['rating'] as int,
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'client_name': clientName,
      'client_image_url': clientImageUrl,
      'rating': rating,
      'description': description,
    };
  }

  factory RatingClientModel.fromEntity(RatingClientEntity entity) {
    return RatingClientModel(
      clientId: entity.clientId,
      clientName: entity.clientName,
      clientImageUrl: entity.clientImageUrl,
      rating: entity.rating,
      description: entity.description,
    );
  }
}
