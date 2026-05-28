import 'package:buildmatch_mobile/features/project_offers/domain/entities/project_offer_entity.dart';

import '../models/project_offer_model.dart';

abstract class ProjectOfferLocalDataSource {
  Future<List<ProjectOfferModel>> getProjectOffers(String projectId);
}

class ProjectOfferLocalDataSourceImpl implements ProjectOfferLocalDataSource {
  @override
  Future<List<ProjectOfferModel>> getProjectOffers(String projectId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    // Dummy data matching the provided UI
    final allOffers = const [
      ProjectOfferModel(
        id: '1',
        name: 'Gibran Rakabuming',
        avatarUrl: 'https://ui-avatars.com/api/?name=Gibran+Rakabuming&background=random',
        role: ProjectOfferRole.architect,
        rating: 4.8,
        reviewsCount: 100,
        price: 20000000, // Rp 20 Juta
        estimatedDays: 15,
        message: 'Kami telah mempelajari rancangan desain Anda dengan saksama. Dengan pengalaman lebih dari 10 tahun di konstruksi residensial modern, ...',
      ),
      ProjectOfferModel(
        id: '2',
        name: 'Masrifatul Ula',
        avatarUrl: 'https://ui-avatars.com/api/?name=Masrifatul+Ula&background=random',
        role: ProjectOfferRole.contractor,
        rating: 4.9,
        reviewsCount: 5000, // 5K
        price: 10000000, // Rp 10 Juta
        estimatedDays: 15,
        message: 'Berdasarkan BQ yang dilampirkan, kami menawarkan struktur baja ringan yang dapat mempercepat proses pembangunan serta ...',
      ),
    ];

    // Filter berdasarkan jenis proyek:
    // - pen_001 & proj_002: Tipe proyek ARSITEK (Hanya menampilkan Arsitek)
    // - pen_002 & proj_001 & proj_003: Tipe proyek KONTRAKTOR (Hanya menampilkan Kontraktor)
    if (projectId == 'pen_001' || projectId == 'proj_002') {
      return allOffers.where((offer) => offer.role == ProjectOfferRole.architect).toList();
    } else if (projectId == 'pen_002' || projectId == 'proj_001' || projectId == 'proj_003') {
      return allOffers.where((offer) => offer.role == ProjectOfferRole.contractor).toList();
    }

    return allOffers;
  }
}
