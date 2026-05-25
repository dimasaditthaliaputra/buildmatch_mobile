import 'package:equatable/equatable.dart';

class ProgressEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final double percentage;
  final List<String> evidencePhotos;
  final String paymentStatus; // e.g., 'LUNAS', 'MENUNGGU'
  final int paymentAmount;

  const ProgressEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.percentage,
    required this.evidencePhotos,
    required this.paymentStatus,
    required this.paymentAmount,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        percentage,
        evidencePhotos,
        paymentStatus,
        paymentAmount,
      ];
}
