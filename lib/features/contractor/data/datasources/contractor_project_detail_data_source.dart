import '../../domain/entities/contractor_project_request_entity.dart'; // Untuk status
import '../../domain/entities/contractor_project_detail_entity.dart';

abstract class ContractorProjectRequestDetailLocalDataSource {
  ContractorProjectDetailEntity getProjectRequestDetail(String id);
}

class ContractorProjectRequestDetailLocalDataSourceImpl implements ContractorProjectRequestDetailLocalDataSource {
  @override
  ContractorProjectDetailEntity getProjectRequestDetail(String id) {
    final Map<String, ContractorProjectDetailEntity> details = {
      '1': const ContractorProjectDetailEntity(
        id: '1',
        title: 'Modern Zen Villa – Pejaten Terrace',
        category: 'RESIDENSIAL',
        location: 'Pejaten Terrace',
        city: 'Jakarta Selatan',
        priceMin: 'Rp 450',     // Diubah dari rentPriceMin
        priceMax: '500jt',      // Diubah dari rentPriceMax
        buildingArea: '120 m²',
        imageUrl: 'assets/images/project_villa.jpg',
        isNew: true,
        status: ProjectRequestStatus.offering,
        buildingHeight: '2 Lantai (8 m²)',
        startDate: 'Jan 2025',
        endDate: 'Des 2025',
        budgetMin: 'Rp 450jt',
        budgetMax: '500jt',
        description:
            'Mencari kontraktor untuk villa 3 kamar tidur dengan konsep industrial-tropical. Fokus pada sirkulasi udara alami, pencahayaan natural, dan material lokal Bali. Diutamakan yang berpengalaman di area taman',
        files: [
          ContractorProjectFile(name: 'Blueprint', type: 'PDF', size: '2.4 MB'),
          ContractorProjectFile(name: 'Exterior_side', type: 'PNG', size: '1.1 MB'),
        ],
        bidCount: 12,
        avgBid: '490jt',
        avgWorkDays: '300 Hari',
        client: ContractorProjectClient(
          name: 'Marcus Chen',
          avatarColor: 'orange',
          isVerified: true,
          location: 'Jakarta',
        ),
      ),
      '2': const ContractorProjectDetailEntity(
        id: '2',
        title: 'Creative Hub Office Expansion',
        category: 'KOMERSIAL',
        location: 'BSD',
        city: 'BSD, Tangerang',
        priceMin: 'Rp 450',
        priceMax: '500jt',
        buildingArea: '120 m²',
        imageUrl: 'assets/images/project_office.jpg',
        isNew: false,
        status: ProjectRequestStatus.offering,
        buildingHeight: '3 Lantai (12 m²)',
        startDate: 'Feb 2025',
        endDate: 'Nov 2025',
        budgetMin: 'Rp 600jt',
        budgetMax: '800jt',
        description:
            'Ekspansi kantor kreatif dengan konsep open space dan coworking area. Butuh kontraktor berpengalaman di proyek komersial skala menengah.',
        files: [
          ContractorProjectFile(name: 'Blueprint_Office', type: 'PDF', size: '3.1 MB'),
          ContractorProjectFile(name: 'Layout_3D', type: 'PNG', size: '2.4 MB'),
        ],
        bidCount: 8,
        avgBid: '700jt',
        avgWorkDays: '250 Hari',
        client: ContractorProjectClient(
          name: 'Rina Dewi',
          avatarColor: 'blue',
          isVerified: true,
          location: 'Tangerang',
        ),
      ),
      '3': const ContractorProjectDetailEntity(
        id: '3',
        title: 'Creative Hub Office Expansion',
        category: 'RESIDENSIAL',
        location: 'BSD',
        city: 'BSD, Tangerang',
        priceMin: 'Rp 450',
        priceMax: '500jt',
        buildingArea: '120 m²',
        imageUrl: 'assets/images/project_creative.jpg',
        isNew: false,
        status: ProjectRequestStatus.ongoing,
        buildingHeight: '2 Lantai (9 m²)',
        startDate: 'Mar 2025',
        endDate: 'Oct 2025',
        budgetMin: 'Rp 350jt',
        budgetMax: '400jt',
        description:
            'Pembangunan rumah tinggal 2 lantai dengan konsep minimalis modern. Material premium dengan finishing berkualitas tinggi.',
        files: [
          ContractorProjectFile(name: 'Denah_Rumah', type: 'PDF', size: '1.8 MB'),
        ],
        bidCount: 5,
        avgBid: '375jt',
        avgWorkDays: '180 Hari',
        client: ContractorProjectClient(
          name: 'Budi Santoso',
          avatarColor: 'green',
          isVerified: false,
          location: 'BSD',
        ),
      ),
    };

    return details[id] ??
        const ContractorProjectDetailEntity(
          id: '0',
          title: 'Unknown Project',
          category: 'RESIDENSIAL',
          location: '',
          city: '',
          priceMin: '',
          priceMax: '',
          buildingArea: '',
          imageUrl: '',
          buildingHeight: '',
          startDate: '',
          endDate: '',
          budgetMin: '',
          budgetMax: '',
          description: '',
          client: ContractorProjectClient(name: '', avatarColor: '', location: ''),
        );
  }
}