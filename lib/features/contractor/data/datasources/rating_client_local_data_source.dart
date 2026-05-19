import '../models/rating_client_model.dart';

abstract class RatingClientLocalDataSource {
  void saveRating(RatingClientModel model);

  List<RatingClientModel> getRatings();
}

class RatingClientLocalDataSourceImpl implements RatingClientLocalDataSource {
  final List<RatingClientModel> _ratings = [];

  @override
  void saveRating(RatingClientModel model) {
    _ratings.add(model);
  }

  @override
  List<RatingClientModel> getRatings() {
    return List.unmodifiable(_ratings);
  }
}
