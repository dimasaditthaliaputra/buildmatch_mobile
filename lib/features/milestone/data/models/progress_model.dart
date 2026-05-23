import '../../domain/entities/progress_entity.dart';

class ProgressModel extends ProgressEntity {
  const ProgressModel({
    required super.id,
    required super.title,
    required super.description,
    required super.percentage,
    required super.evidencePhotos,
    required super.paymentStatus,
    required super.paymentAmount,
  });

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      evidencePhotos: List<String>.from(json['evidencePhotos'] ?? []),
      paymentStatus: json['paymentStatus'] ?? '',
      paymentAmount: json['paymentAmount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'percentage': percentage,
      'evidencePhotos': evidencePhotos,
      'paymentStatus': paymentStatus,
      'paymentAmount': paymentAmount,
    };
  }
}
