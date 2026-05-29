import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/review_entity.dart';
import '../repositories/rating_repository.dart';

class GetReviewsUseCase {
  final RatingRepository repository;

  GetReviewsUseCase(this.repository);

  Future<Either<Failure, List<ReviewEntity>>> call({String filter = 'all'}) async {
    return await repository.getReviews(filter: filter);
  }
}
