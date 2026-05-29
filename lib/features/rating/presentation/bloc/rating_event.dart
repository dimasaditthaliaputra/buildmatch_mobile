import 'package:equatable/equatable.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object?> get props => [];
}

class FetchRatingsEvent extends RatingEvent {
  final String filter; // 'all', 'satisfied', 'with_photos', 'highest', 'lowest'

  const FetchRatingsEvent({this.filter = 'all'});

  @override
  List<Object?> get props => [filter];
}

class RefreshRatingsEvent extends RatingEvent {
  final String filter;

  const RefreshRatingsEvent({this.filter = 'all'});

  @override
  List<Object?> get props => [filter];
}
