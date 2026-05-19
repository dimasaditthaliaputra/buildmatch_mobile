import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/rating_client_entity.dart';
import '../../domain/usecases/get_submit_rating_client.dart';
import 'rating_client_event.dart';
import 'rating_client_state.dart';

class RatingClientBloc extends Bloc<RatingClientEvent, RatingClientState> {
  final SubmitRatingClient submitRatingClient;

  RatingClientBloc({required this.submitRatingClient})
      : super(const RatingClientState()) {
    on<LoadRatingClientData>(_onLoadData);
    on<RatingStarSelected>(_onStarSelected);
    on<RatingDescriptionChanged>(_onDescriptionChanged);
    on<SubmitRatingClientRequested>(_onSubmit);
  }

  void _onLoadData(
    LoadRatingClientData event,
    Emitter<RatingClientState> emit,
  ) {
    emit(state.copyWith(
      clientId: event.clientId,
      clientName: event.clientName,
      clientImageUrl: event.clientImageUrl,
      status: RatingClientStatus.initial,
    ));
  }

  void _onStarSelected(
    RatingStarSelected event,
    Emitter<RatingClientState> emit,
  ) {
    emit(state.copyWith(selectedRating: event.rating));
  }

  void _onDescriptionChanged(
    RatingDescriptionChanged event,
    Emitter<RatingClientState> emit,
  ) {
    emit(state.copyWith(description: event.description));
  }

  void _onSubmit(
    SubmitRatingClientRequested event,
    Emitter<RatingClientState> emit,
  ) {
    if (state.selectedRating == 0) {
      emit(state.copyWith(
        status: RatingClientStatus.failure,
        errorMessage: 'Pilih rating terlebih dahulu.',
      ));
      return;
    }

    emit(state.copyWith(status: RatingClientStatus.loading));

    final entity = RatingClientEntity(
      clientId: state.clientId,
      clientName: state.clientName,
      clientImageUrl: state.clientImageUrl,
      rating: state.selectedRating,
      description: state.description,
    );

    submitRatingClient.execute(entity);

    emit(state.copyWith(status: RatingClientStatus.success));
  }
}
