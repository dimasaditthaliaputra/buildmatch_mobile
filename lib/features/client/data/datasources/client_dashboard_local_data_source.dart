import '../models/client_dashboard_model.dart';

abstract class ClientDashboardLocalDataSource {
  Future<ClientDashboardModel> getDashboardData(String clientId);
}

class ClientDashboardLocalDataSourceImpl
    implements ClientDashboardLocalDataSource {
  @override
  Future<ClientDashboardModel> getDashboardData(String clientId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ClientDashboardModel.fromJson(_mockData);
  }

  static const Map<String, dynamic> _mockData = {
    'client_name': 'Vanea',
    'greeting': 'Selamat Siang',
    'avatar_url': null,
    'popular_projects': [
      {
        'id': 'pop_001',
        'name': 'The Glass Pavilion',
        'type': 'Kontraktor',
        'rating': 4.8,
        'image_url': null,
        'is_favorited': false,
      },
      {
        'id': 'pop_002',
        'name': 'Modern Villa',
        'type': 'Arsitek',
        'rating': 4.7,
        'image_url': null,
        'is_favorited': false,
      },
      {
        'id': 'pop_003',
        'name': 'Tropical Retreat',
        'type': 'Kontraktor',
        'rating': 4.9,
        'image_url': null,
        'is_favorited': true,
      },
    ],
  };
}
