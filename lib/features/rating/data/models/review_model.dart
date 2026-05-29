import '../../domain/entities/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.clientName,
    super.clientAvatarUrl,
    required super.rating,
    required super.createdAt,
    required super.content,
    required super.tags,
    required super.photos,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String? ?? '',
      clientName: json['client_name'] as String? ?? 'Pengguna Anonim',
      clientAvatarUrl: json['client_avatar_url'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      content: json['content'] as String? ?? '',
      tags: (json['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'client_name': clientName,
      'client_avatar_url': clientAvatarUrl,
      'rating': rating,
      'created_at': createdAt.toIso8601String(),
      'content': content,
      'tags': tags,
      'photos': photos,
    };
  }
}
