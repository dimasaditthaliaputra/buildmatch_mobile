import '../../domain/entities/architect_project_offer_entity.dart';

class ArchitectProjectOfferModel extends ArchitectProjectOfferEntity {
  const ArchitectProjectOfferModel({
    required super.id,
    required super.projectId,
    required super.architectId,
    required super.budgetMin,
    required super.budgetMax,
    required super.pesan,
    required super.estimasiWaktu,
    super.status,
    required super.createdAt,
  });

  factory ArchitectProjectOfferModel.fromJson(Map<String, dynamic> json) {
    return ArchitectProjectOfferModel(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      architectId: json['architect_id'] as String,
      budgetMin: (json['budget_min'] as num).toInt(),
      budgetMax: (json['budget_max'] as num).toInt(),
      pesan: json['pesan'] as String,
      estimasiWaktu: DateTime.parse(json['estimasi_waktu'] as String),
      status: _statusFromString(json['status'] as String? ?? 'menunggu'),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_id': projectId,
      'architect_id': architectId,
      'budget_min': budgetMin,
      'budget_max': budgetMax,
      'pesan': pesan,
      'estimasi_waktu': estimasiWaktu.toIso8601String(),
    };
  }

  static PenawaranStatus _statusFromString(String status) {
    switch (status) {
      case 'diterima':
        return PenawaranStatus.diterima;
      case 'ditolak':
        return PenawaranStatus.ditolak;
      case 'menunggu':
      default:
        return PenawaranStatus.menunggu;
    }
  }

  ArchitectProjectOfferModel copyWith({
    String? id,
    String? projectId,
    String? contractorId,
    int? budgetMin,
    int? budgetMax,
    String? pesan,
    DateTime? estimasiWaktu,
    PenawaranStatus? status,
    DateTime? createdAt,
  }) {
    return ArchitectProjectOfferModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      architectId: contractorId ?? this.architectId,
      budgetMin: budgetMin ?? this.budgetMin,
      budgetMax: budgetMax ?? this.budgetMax,
      pesan: pesan ?? this.pesan,
      estimasiWaktu: estimasiWaktu ?? this.estimasiWaktu,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}