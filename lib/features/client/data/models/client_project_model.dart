import '../../domain/entities/client_project_entity.dart';

class ClientProjectModel extends ClientProjectEntity {
  const ClientProjectModel({
    required super.id,
    required super.name,
    required super.location,
    required super.startDate,
    required super.status,
    required super.phase,
    required super.progressPercent,
    super.professionalName,
    required super.professionalType,
    super.endDate,
  });

  factory ClientProjectModel.fromJson(Map<String, dynamic> json) {
    return ClientProjectModel(
      id: json['id'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      startDate: json['start_date'] as String,
      status: json['status'] as String,
      phase: json['phase'] as String,
      progressPercent: (json['progress_percent'] as num).toDouble(),
      professionalName: json['professional_name'] as String?,
      professionalType: json['professional_type'] as String? ?? 'KONTRAKTOR',
      endDate: json['end_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'location': location,
      'start_date': startDate,
      'status': status,
      'phase': phase,
      'progress_percent': progressPercent,
      'professional_name': professionalName,
      'professional_type': professionalType,
      'end_date': endDate,
    };
  }
}
