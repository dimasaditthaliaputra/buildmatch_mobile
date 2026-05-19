import '../entities/rating_client_entity.dart';
import '../repositories/rating_client_repository.dart';

class SubmitRatingClient {
  final RatingClientRepository repository;

  SubmitRatingClient(this.repository);

  void execute(RatingClientEntity rating) {
    repository.submitRating(rating);
  }
}
