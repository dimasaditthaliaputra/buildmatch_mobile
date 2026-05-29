import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/rating_stat_entity.dart';
import '../entities/review_entity.dart';

abstract class RatingRepository {
  Future<Either<Failure, RatingStatEntity>> getRatingStats();
  Future<Either<Failure, List<ReviewEntity>>> getReviews({
    String filter = 'all', // 'all', 'satisfied', 'with_photos', 'highest', 'lowest'
  });
}
