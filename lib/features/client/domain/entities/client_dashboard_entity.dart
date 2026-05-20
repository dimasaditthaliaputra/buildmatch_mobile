class ClientDashboardEntity {
  final String clientName;
  final String greeting;
  final String? avatarUrl;
  final List<PopularProjectEntity> popularProjects;

  const ClientDashboardEntity({
    required this.clientName,
    required this.greeting,
    this.avatarUrl,
    required this.popularProjects,
  });
}

class PopularProjectEntity {
  final String id;
  final String name;
  final String type; // 'Kontraktor' | 'Arsitek'
  final double rating;
  final String? imageUrl;
  final bool isFavorited;

  const PopularProjectEntity({
    required this.id,
    required this.name,
    required this.type,
    required this.rating,
    this.imageUrl,
    this.isFavorited = false,
  });
}
