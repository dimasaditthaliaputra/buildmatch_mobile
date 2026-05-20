import '../../domain/entities/client_dashboard_entity.dart';

class PopularProjectModel extends PopularProjectEntity {
  const PopularProjectModel({
    required super.id,
    required super.name,
    required super.type,
    required super.rating,
    super.imageUrl,
    super.isFavorited,
  });

  factory PopularProjectModel.fromJson(Map<String, dynamic> json) {
    return PopularProjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      rating: (json['rating'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      isFavorited: json['is_favorited'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'rating': rating,
      'image_url': imageUrl,
      'is_favorited': isFavorited,
    };
  }
}

class ClientDashboardModel extends ClientDashboardEntity {
  const ClientDashboardModel({
    required super.clientName,
    required super.greeting,
    super.avatarUrl,
    required super.popularProjects,
  });

  factory ClientDashboardModel.fromJson(Map<String, dynamic> json) {
    final projectsJson = json['popular_projects'] as List<dynamic>? ?? [];
    return ClientDashboardModel(
      clientName: json['client_name'] as String,
      greeting: json['greeting'] as String,
      avatarUrl: json['avatar_url'] as String?,
      popularProjects: projectsJson
          .map((e) => PopularProjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_name': clientName,
      'greeting': greeting,
      'avatar_url': avatarUrl,
      'popular_projects': (popularProjects as List<PopularProjectModel>)
          .map((e) => e.toJson())
          .toList(),
    };
  }
}
