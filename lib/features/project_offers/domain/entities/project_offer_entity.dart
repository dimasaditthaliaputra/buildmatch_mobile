import 'package:equatable/equatable.dart';

enum ProjectOfferRole { architect, contractor }

class ProjectOfferEntity extends Equatable {
  final String id;
  final String name;
  final String avatarUrl;
  final ProjectOfferRole role;
  final double rating;
  final int reviewsCount;
  final double price; // in Rupiah (e.g., 20000000 for 20 Juta)
  final int estimatedDays;
  final String message;

  const ProjectOfferEntity({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.role,
    required this.rating,
    required this.reviewsCount,
    required this.price,
    required this.estimatedDays,
    required this.message,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        avatarUrl,
        role,
        rating,
        reviewsCount,
        price,
        estimatedDays,
        message,
      ];
}
