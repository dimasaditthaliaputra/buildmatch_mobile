import '../../domain/entities/rating_stat_entity.dart';

class RatingStatModel extends RatingStatEntity {
  const RatingStatModel({
    required super.averageRating,
    required super.totalReviews,
    required super.totalSatisfied,
    required super.totalWithPhotos,
    required super.ratingCounts,
  });

  factory RatingStatModel.fromJson(Map<String, dynamic> json) {
    return RatingStatModel(
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      totalReviews: json['total_reviews'] as int? ?? 0,
      totalSatisfied: json['total_satisfied'] as int? ?? 0,
      totalWithPhotos: json['total_with_photos'] as int? ?? 0,
      ratingCounts: {
        5: json['count_5_star'] as int? ?? 0,
        4: json['count_4_star'] as int? ?? 0,
        3: json['count_3_star'] as int? ?? 0,
        2: json['count_2_star'] as int? ?? 0,
        1: json['count_1_star'] as int? ?? 0,
      },
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'average_rating': averageRating,
      'total_reviews': totalReviews,
      'total_satisfied': totalSatisfied,
      'total_with_photos': totalWithPhotos,
      'count_5_star': ratingCounts[5] ?? 0,
      'count_4_star': ratingCounts[4] ?? 0,
      'count_3_star': ratingCounts[3] ?? 0,
      'count_2_star': ratingCounts[2] ?? 0,
      'count_1_star': ratingCounts[1] ?? 0,
    };
  }
}
