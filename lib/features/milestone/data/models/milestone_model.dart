import '../../domain/entities/milestone_entity.dart';
import 'progress_model.dart';

class MilestoneModel extends MilestoneEntity {
  const MilestoneModel({
    required super.id,
    required super.title,
    required super.description,
    required super.status,
    required super.isConstruction,
    required super.paymentAmount,
    required super.paymentStatus,
    required super.evidencePhotos,
    super.progressList,
    required super.completionPercentage,
  });

  factory MilestoneModel.fromJson(Map<String, dynamic> json) {
    return MilestoneModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? '',
      isConstruction: json['isConstruction'] ?? false,
      paymentAmount: json['paymentAmount'] ?? 0,
      paymentStatus: json['paymentStatus'] ?? '',
      evidencePhotos: List<String>.from(json['evidencePhotos'] ?? []),
      progressList: json['progressList'] != null
          ? (json['progressList'] as List)
              .map((e) => ProgressModel.fromJson(e))
              .toList()
          : null,
      completionPercentage: (json['completionPercentage'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'isConstruction': isConstruction,
      'paymentAmount': paymentAmount,
      'paymentStatus': paymentStatus,
      'evidencePhotos': evidencePhotos,
      'progressList': progressList?.map((e) => (e as ProgressModel).toJson()).toList(),
      'completionPercentage': completionPercentage,
    };
  }
}
