class RatingClientEntity {
  final String clientId;
  final String clientName;
  final String? clientImageUrl;
  final int rating; 
  final String description;

  const RatingClientEntity({
    required this.clientId,
    required this.clientName,
    this.clientImageUrl,
    required this.rating,
    required this.description,
  });
}
