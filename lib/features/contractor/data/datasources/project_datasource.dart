import '../../domain/entities/project_entity.dart';

abstract class ProjectLocalDataSource {
  List<ProjectEntity> getProjects();
}

class ProjectLocalDataSourceImpl implements ProjectLocalDataSource {
  @override
  List<ProjectEntity> getProjects() {
    return [
      const ProjectEntity(
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
      ),
      const ProjectEntity(
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
      ),
      const ProjectEntity(
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
      ),
    ];
  }
}
