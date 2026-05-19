enum RatingClientStatus { initial, loading, success, failure }

class RatingClientState {
  final String clientId;
  final String clientName;
  final String? clientImageUrl;
  final int selectedRating;   // 0 = belum dipilih, 1–5 = bintang terpilih
  final String description;
  final RatingClientStatus status;
  final String? errorMessage;

  const RatingClientState({
    this.clientId = '',
    this.clientName = '',
    this.clientImageUrl,
    this.selectedRating = 0,
    this.description = '',
    this.status = RatingClientStatus.initial,
    this.errorMessage,
  });

  RatingClientState copyWith({
    String? clientId,
    String? clientName,
    String? clientImageUrl,
    int? selectedRating,
    String? description,
    RatingClientStatus? status,
    String? errorMessage,
  }) {
    return RatingClientState(
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      clientImageUrl: clientImageUrl ?? this.clientImageUrl,
      selectedRating: selectedRating ?? this.selectedRating,
      description: description ?? this.description,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
