import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/rating_stat_entity.dart';
import '../repositories/rating_repository.dart';

class GetRatingStatsUseCase {
  final RatingRepository repository;

  GetRatingStatsUseCase(this.repository);

  Future<Either<Failure, RatingStatEntity>> call() async {
    return await repository.getRatingStats();
  }
}
