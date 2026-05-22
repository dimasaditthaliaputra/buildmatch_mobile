import '../models/architect_dashboard_model.dart';

abstract class ArchitectDashboardRemoteDataSource {
  Future<ArchitectDashboardModel> getDashboardData(String contractorId);
}

class ArchitectDashboardRemoteDataSourceImpl
    implements ArchitectDashboardRemoteDataSource {
  // Inject Supabase client here in real implementation
  // final SupabaseClient supabaseClient;

  @override
  Future<ArchitectDashboardModel> getDashboardData(
    String architectId
  ) async {
    // Replace with actual Supabase call:
    // final response = await supabaseClient
    //     .from('architect_dashboard')
    //     .select('*')
    //     .eq('architect_id', architectId)
    //     .single();
    // return ArchitectDashboardModel.fromJson(response);

    // Mock data — replace with real API call
    await Future.delayed(const Duration(milliseconds: 500));
    return ArchitectDashboardModel.fromJson(_mockData);
  }

  static const Map<String, dynamic> _mockData = {
    'architect_name': 'UrbanCore',
    'architect_role': 'buildkedu',
    'avatar_url': null,
    'financial_summary': {
      'total_income': 54000000,
      'disbursed': 30000000,
      'not_disbursed': 24000000,
      'disbursed_transactions': 8,
      'pending_transactions': 3,
      'disbursed_count': 8,
      'not_disbursed_count': 3,
      'period': 'Tahun 2024',
    },
    'active_projects': [
      {
        'id': 'proj_001',
        'name': 'Modern Zen Villa',
        'location': 'Cibubur',
        'phase': 'Fase 3: Konstruksi & Pengawasan',
        'progress_percent': 0.65,
        'status': 'AKTIF',
        'target_date': 'Est. 2024',
        'start_date': 'Mulai Jun 2024',
        'image_url': null,
      },
    ],
    'project_listings': [
      {
        'id': 'list_001',
        'name': 'Minimalis Studio Office',
        'location': 'Jakarta Selatan',
        'min_price': 470000000,
        'max_price': 900000000,
        'building_area': 120.0,
        'is_new': true,
      },
      {
        'id': 'list_002',
        'name': 'Tropical Retreat Villa',
        'location': 'Ubud, Bali',
        'min_price': 2000000000,
        'max_price': 3500000000,
        'building_area': 350.0,
        'is_new': true,
      },
    ],
    'financial_chart_data': [
      {'month': 'JAN', 'income': 20000000, 'expense': 15000000},
      {'month': 'FEB', 'income': 25000000, 'expense': 18000000},
      {'month': 'MAR', 'income': 30000000, 'expense': 22000000},
      {'month': 'APR', 'income': 28000000, 'expense': 20000000},
      {'month': 'MEI', 'income': 35000000, 'expense': 25000000},
      {'month': 'JUN', 'income': 40000000, 'expense': 30000000},
      {'month': 'JUL', 'income': 38000000, 'expense': 28000000},
    ],
    'project_stats': {
      'total': 24,
      'active': 10,
      'done': 6,
      'pending': 8,
      'average_rating': 4.9,
    },
  };
}