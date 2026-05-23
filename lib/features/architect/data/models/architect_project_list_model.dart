import '../../domain/entities/architect_project_list_entity.dart';

class ArchitectProjectListModel extends ArchitectProjectListEntity {
  const ArchitectProjectListModel({
    required super.id,
    required super.name,
    required super.location,
    required super.startDate,
    required super.clientName,
    required super.status,
  });

  factory ArchitectProjectListModel.fromJson(Map<String, dynamic> json) {
    return ArchitectProjectListModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      clientName: json['client_name'] as String,
      status: (json['status'] as String) == 'berjalan'
          ? ProjectStatus.berjalan
          : ProjectStatus.selesai,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'start_date': startDate.toIso8601String(),
      'client_name': clientName,
      'status': status == ProjectStatus.berjalan ? 'berjalan' : 'selesai',
    };
  }
}