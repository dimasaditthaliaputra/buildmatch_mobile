import '../../domain/entities/rating_client_entity.dart';
import '../../domain/repositories/rating_client_repository.dart';
import '../datasources/rating_client_local_data_source.dart';
import '../models/rating_client_model.dart';

class RatingClientRepositoryImpl implements RatingClientRepository {
  final RatingClientLocalDataSource localDataSource;

  RatingClientRepositoryImpl(this.localDataSource);

  @override
  void submitRating(RatingClientEntity rating) {
    final model = RatingClientModel.fromEntity(rating);
    localDataSource.saveRating(model);
  }
}
