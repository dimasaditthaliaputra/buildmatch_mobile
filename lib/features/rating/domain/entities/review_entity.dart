import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String clientName;
  final String? clientAvatarUrl;
  final double rating;
  final DateTime createdAt;
  final String content;
  final List<String> tags;
  final List<String> photos;

  const ReviewEntity({
    required this.id,
    required this.clientName,
    this.clientAvatarUrl,
    required this.rating,
    required this.createdAt,
    required this.content,
    required this.tags,
    required this.photos,
  });

  @override
  List<Object?> get props => [
        id,
        clientName,
        clientAvatarUrl,
        rating,
        createdAt,
        content,
        tags,
        photos,
      ];
}
