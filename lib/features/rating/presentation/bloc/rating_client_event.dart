abstract class RatingClientEvent {}

/// Dipanggil saat halaman pertama dibuka — load data client.
class LoadRatingClientData extends RatingClientEvent {
  final String clientId;
  final String clientName;
  final String? clientImageUrl;

  LoadRatingClientData({
    required this.clientId,
    required this.clientName,
    this.clientImageUrl,
  });
}

/// Dipanggil saat pengguna memilih bintang.
class RatingStarSelected extends RatingClientEvent {
  final int rating;
  RatingStarSelected(this.rating);
}

/// Dipanggil saat pengguna mengetik deskripsi.
class RatingDescriptionChanged extends RatingClientEvent {
  final String description;
  RatingDescriptionChanged(this.description);
}

/// Dipanggil saat pengguna menekan tombol kirim.
class SubmitRatingClientRequested extends RatingClientEvent {}
