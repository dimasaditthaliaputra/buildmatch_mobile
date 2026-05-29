import '../models/architect_project_request_model.dart';
import '../../domain/entities/architect_project_request_entity.dart';

abstract class ArchitectProjectRequestLocalDataSource {
  List<ArchitectProjectRequestModel> getArchitectProjectRequests();
}

class ArchitectProjectRequestLocalDataSourceImpl implements ArchitectProjectRequestLocalDataSource {
  @override
  List<ArchitectProjectRequestModel> getArchitectProjectRequests() {
    return [
      const ArchitectProjectRequestModel(
        id: '1',
        title: 'Modern Zen Villa – Pejaten Terrace',
        category: 'RESIDENSIAL',
        location: 'Pejaten Terrace',
        city: 'Jakarta Selatan',
        priceMin: 'Rp 450',
        priceMax: '500jt',
        buildingArea: '120 m²',
        imageUrl: 'assets/images/project_villa.jpg',
        isNew: true,
        status: ProjectRequestStatus.offering,
      ),
      const ArchitectProjectRequestModel(
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
      ),
      const ArchitectProjectRequestModel(
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
      ),
    ];
  }
}