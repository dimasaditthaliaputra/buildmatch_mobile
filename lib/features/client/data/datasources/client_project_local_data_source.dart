import '../models/client_project_model.dart';

abstract class ClientProjectLocalDataSource {
  Future<List<ClientProjectModel>> getPenawaranProjects(String clientId);
  Future<List<ClientProjectModel>> getAllProjects(String clientId);
}

class ClientProjectLocalDataSourceImpl implements ClientProjectLocalDataSource {
  @override
  Future<List<ClientProjectModel>> getPenawaranProjects(
      String clientId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _penawaranMockData
        .map((e) => ClientProjectModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<ClientProjectModel>> getAllProjects(String clientId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _allProjectsMockData
        .map((e) => ClientProjectModel.fromJson(e))
        .toList();
  }

  static const List<Map<String, dynamic>> _penawaranMockData = [
    {
      'id': 'pen_001',
      'name': 'Renovasi Dapur & Taman',
      'location': 'Kerobokan, Bali',
      'start_date': '18 Juli 2024',
      'status': 'MENUNGGU',
      'phase': 'Menunggu Penawaran',
      'progress_percent': 0.0,
      'professional_name': null,
      'professional_type': 'ARSITEK',
      'end_date': null,
    },
    {
      'id': 'pen_002',
      'name': 'Proyek Pembangunan PT. Indah',
      'location': 'Kerobokan, Bali',
      'start_date': '18 Juli 2024',
      'status': 'MENUNGGU',
      'phase': 'Menunggu Penawaran',
      'progress_percent': 0.0,
      'professional_name': null,
      'professional_type': 'KONTRAKTOR',
      'end_date': null,
    },
  ];

  static const List<Map<String, dynamic>> _allProjectsMockData = [
    {
      'id': 'proj_001',
      'name': 'Modern Zen Villa',
      'location': 'Uluwatu, Bali',
      'start_date': '12 Juni 2024',
      'status': 'BERJALAN',
      'phase': 'Fase 3 - Perizinan & Kontrak',
      'progress_percent': 0.65,
      'professional_name': 'UrbanCore Construction',
      'professional_type': 'KONTRAKTOR',
      'end_date': null,
    },
    {
      'id': 'proj_002',
      'name': 'Rumah Tropis Minimalis',
      'location': 'Seminyak, Bali',
      'start_date': '03 Juli 2024',
      'status': 'REVIEW',
      'phase': 'Fase 2 - Pembuatan Desain',
      'progress_percent': 0.40,
      'professional_name': 'Ars. Sarah Wijaya',
      'professional_type': 'ARSITEK',
      'end_date': null,
    },
    {
      'id': 'proj_003',
      'name': 'Tropical Residence',
      'location': 'Canggu, Bali',
      'start_date': '01 Maret 2024',
      'status': 'SELESAI',
      'phase': 'Semua Fase Selesai',
      'progress_percent': 1.0,
      'professional_name': 'CV. Bangun Abadi',
      'professional_type': 'KONTRAKTOR',
      'end_date': '24 Oktober 2024',
    },
  ];
}
