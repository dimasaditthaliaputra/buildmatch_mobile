import '../../domain/entities/project_detail_entity.dart';
import '../../domain/entities/project_entity.dart';

abstract class ProjectDetailLocalDataSource {
  ProjectDetailEntity getProjectDetail(String id);
}

class ProjectDetailLocalDataSourceImpl implements ProjectDetailLocalDataSource {
  @override
  ProjectDetailEntity getProjectDetail(String id) {
    final Map<String, ProjectDetailEntity> details = {
      '1': const ProjectDetailEntity(
        id: '1',
        title: 'Modern Zen Villa – Pejaten Terrace',
        category: 'RESIDENSIAL',
        location: 'Pejaten Terrace',
        city: 'Jakarta Selatan',
        rentPriceMin: 'Rp 450',
        rentPriceMax: '500jt',
        buildingArea: '120 m²',
        imageUrl: 'assets/images/project_villa.jpg',
        isNew: true,
        status: ProjectStatus.offering,
        buildingHeight: '2 Lantai (8 m²)',
        startDate: 'Jan 2025',
        endDate: 'Des 2025',
        budgetMin: 'Rp 450jt',
        budgetMax: '500jt',
        description:
            'Mencari kontraktor untuk villa 3 kamar tidur dengan konsep industrial-tropical. Fokus pada sirkulasi udara alami, pencahayaan natural, dan material lokal Bali. Diutamakan yang berpengalaman di area taman',
        files: [
          ProjectFile(name: 'Blueprint', type: 'PDF', size: '2.4 MB'),
          ProjectFile(name: 'Exterior_side', type: 'PNG', size: '1.1 MB'),
        ],
        bidCount: 12,
        avgBid: '490jt',
        avgWorkDays: '300 Hari',
        client: ProjectClient(
          name: 'Marcus Chen',
          avatarColor: 'orange',
          isVerified: true,
          location: 'Jakarta',
        ),
      ),
      '2': const ProjectDetailEntity(
        id: '2',
        title: 'Creative Hub Office Expansion',
        category: 'KOMERSIAL',
        location: 'BSD',
        city: 'BSD, Tangerang',
        rentPriceMin: 'Rp 450',
        rentPriceMax: '500jt',
        buildingArea: '120 m²',
        imageUrl: 'assets/images/project_office.jpg',
        isNew: false,
        status: ProjectStatus.offering,
        buildingHeight: '3 Lantai (12 m²)',
        startDate: 'Feb 2025',
        endDate: 'Nov 2025',
        budgetMin: 'Rp 600jt',
        budgetMax: '800jt',
        description:
            'Ekspansi kantor kreatif dengan konsep open space dan coworking area. Butuh kontraktor berpengalaman di proyek komersial skala menengah.',
        files: [
          ProjectFile(name: 'Blueprint_Office', type: 'PDF', size: '3.1 MB'),
          ProjectFile(name: 'Layout_3D', type: 'PNG', size: '2.4 MB'),
        ],
        bidCount: 8,
        avgBid: '700jt',
        avgWorkDays: '250 Hari',
        client: ProjectClient(
          name: 'Rina Dewi',
          avatarColor: 'blue',
          isVerified: true,
          location: 'Tangerang',
        ),
      ),
      '3': const ProjectDetailEntity(
        id: '3',
        title: 'Creative Hub Office Expansion',
        category: 'RESIDENSIAL',
        location: 'BSD',
        city: 'BSD, Tangerang',
        rentPriceMin: 'Rp 450',
        rentPriceMax: '500jt',
        buildingArea: '120 m²',
        imageUrl: 'assets/images/project_creative.jpg',
        isNew: false,
        status: ProjectStatus.ongoing,
        buildingHeight: '2 Lantai (9 m²)',
        startDate: 'Mar 2025',
        endDate: 'Oct 2025',
        budgetMin: 'Rp 350jt',
        budgetMax: '400jt',
        description:
            'Pembangunan rumah tinggal 2 lantai dengan konsep minimalis modern. Material premium dengan finishing berkualitas tinggi.',
        files: [
          ProjectFile(name: 'Denah_Rumah', type: 'PDF', size: '1.8 MB'),
        ],
        bidCount: 5,
        avgBid: '375jt',
        avgWorkDays: '180 Hari',
        client: ProjectClient(
          name: 'Budi Santoso',
          avatarColor: 'green',
          isVerified: false,
          location: 'BSD',
        ),
      ),
    };

    return details['1'] ??
        const ProjectDetailEntity(
          id: '0',
          title: 'Unknown Project',
          category: 'RESIDENSIAL',
          location: '',
          city: '',
          rentPriceMin: '',
          rentPriceMax: '',
          buildingArea: '',
          imageUrl: '',
          buildingHeight: '',
          startDate: '',
          endDate: '',
          budgetMin: '',
          budgetMax: '',
          description: '',
          client: ProjectClient(name: '', avatarColor: '', location: ''),
        );
  }
}
