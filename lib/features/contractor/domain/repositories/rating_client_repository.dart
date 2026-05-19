import '../entities/rating_client_entity.dart';

abstract class RatingClientRepository {
  void submitRating(RatingClientEntity rating);
}
