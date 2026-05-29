import 'package:equatable/equatable.dart';
import '../../domain/entities/rating_stat_entity.dart';
import '../../domain/entities/review_entity.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object?> get props => [];
}

class RatingInitial extends RatingState {}

class RatingLoading extends RatingState {}

class RatingLoaded extends RatingState {
  final RatingStatEntity stats;
  final List<ReviewEntity> reviews;
  final String activeFilter;

  const RatingLoaded({
    required this.stats,
    required this.reviews,
    required this.activeFilter,
  });

  @override
  List<Object?> get props => [stats, reviews, activeFilter];
}

class RatingError extends RatingState {
  final String message;

  const RatingError({required this.message});

  @override
  List<Object?> get props => [message];
}
