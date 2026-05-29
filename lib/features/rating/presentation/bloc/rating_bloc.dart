import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_rating_stats_usecase.dart';
import '../../domain/usecases/get_reviews_usecase.dart';
import 'rating_event.dart';
import 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final GetRatingStatsUseCase getRatingStatsUseCase;
  final GetReviewsUseCase getReviewsUseCase;

  RatingBloc({
    required this.getRatingStatsUseCase,
    required this.getReviewsUseCase,
  }) : super(RatingInitial()) {
    on<FetchRatingsEvent>(_onFetchRatings);
    on<RefreshRatingsEvent>(_onRefreshRatings);
  }

  Future<void> _onFetchRatings(
    FetchRatingsEvent event,
    Emitter<RatingState> emit,
  ) async {
    emit(RatingLoading());

    final statsEither = await getRatingStatsUseCase();
    final reviewsEither = await getReviewsUseCase(filter: event.filter);

    statsEither.fold(
      (failure) => emit(RatingError(message: failure.message)),
      (stats) {
        reviewsEither.fold(
          (failure) => emit(RatingError(message: failure.message)),
          (reviews) {
            emit(RatingLoaded(
              stats: stats,
              reviews: reviews,
              activeFilter: event.filter,
            ));
          },
        );
      },
    );
  }

  Future<void> _onRefreshRatings(
    RefreshRatingsEvent event,
    Emitter<RatingState> emit,
  ) async {
    final statsEither = await getRatingStatsUseCase();
    final reviewsEither = await getReviewsUseCase(filter: event.filter);

    statsEither.fold(
      (failure) => emit(RatingError(message: failure.message)),
      (stats) {
        reviewsEither.fold(
          (failure) => emit(RatingError(message: failure.message)),
          (reviews) {
            emit(RatingLoaded(
              stats: stats,
              reviews: reviews,
              activeFilter: event.filter,
            ));
          },
        );
      },
    );
  }
}
