import 'package:equatable/equatable.dart';
import 'progress_entity.dart';

class MilestoneEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String status; // 'SELESAI', 'MENUNGGU', 'BELUM MULAI'
  final bool isConstruction; // True if it contains progress list
  final int paymentAmount;
  final String paymentStatus; // 'LUNAS', 'MENUNGGU', ''
  final List<String> evidencePhotos;
  final List<ProgressEntity>? progressList;
  final double completionPercentage;

  const MilestoneEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.isConstruction,
    required this.paymentAmount,
    required this.paymentStatus,
    required this.evidencePhotos,
    this.progressList,
    required this.completionPercentage,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        isConstruction,
        paymentAmount,
        paymentStatus,
        evidencePhotos,
        progressList,
        completionPercentage,
      ];
}
