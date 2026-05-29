import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/rating_stat_entity.dart';
import '../../domain/entities/review_entity.dart';
import '../../domain/repositories/rating_repository.dart';
import '../datasources/rating_local_data_source.dart';

class RatingRepositoryImpl implements RatingRepository {
  final RatingLocalDataSource localDataSource;

  RatingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, RatingStatEntity>> getRatingStats() async {
    try {
      final result = await localDataSource.getRatingStats();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure('Failed to load rating stats: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ReviewEntity>>> getReviews({
    String filter = 'all',
  }) async {
    try {
      final result = await localDataSource.getReviews();
      
      // Perform local filtering for the mock
      List<ReviewEntity> filteredResult = result;
      switch (filter) {
        case 'satisfied':
          filteredResult = result.where((r) => r.rating >= 4.0).toList();
          break;
        case 'with_photos':
          filteredResult = result.where((r) => r.photos.isNotEmpty).toList();
          break;
        case 'highest':
          filteredResult = List.from(result)..sort((a, b) => b.rating.compareTo(a.rating));
          break;
        case 'lowest':
          filteredResult = List.from(result)..sort((a, b) => a.rating.compareTo(b.rating));
          break;
        case 'all':
        default:
          break;
      }
      
      return Right(filteredResult);
    } catch (e) {
      return Left(ServerFailure('Failed to load reviews: $e'));
    }
  }
}
