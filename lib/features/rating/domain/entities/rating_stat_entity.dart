import 'package:equatable/equatable.dart';

class RatingStatEntity extends Equatable {
  final double averageRating;
  final int totalReviews;
  final int totalSatisfied; // "Puas"
  final int totalWithPhotos; // "Ada Foto"
  final Map<int, int> ratingCounts; // Star (1-5) -> Count

  const RatingStatEntity({
    required this.averageRating,
    required this.totalReviews,
    required this.totalSatisfied,
    required this.totalWithPhotos,
    required this.ratingCounts,
  });

  @override
  List<Object?> get props => [
        averageRating,
        totalReviews,
        totalSatisfied,
        totalWithPhotos,
        ratingCounts,
      ];
}
