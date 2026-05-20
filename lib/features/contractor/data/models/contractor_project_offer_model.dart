import '../../domain/entities/contractor_project_offer_entity.dart';

class ContractorProjectOfferModel extends ContractorProjectOfferEntity {
  const ContractorProjectOfferModel({
    required super.id,
    required super.projectId,
    required super.contractorId,
    required super.budgetMin,
    required super.budgetMax,
    required super.pesan,
    required super.estimasiWaktu,
    super.status,
    required super.createdAt,
  });

  factory ContractorProjectOfferModel.fromJson(Map<String, dynamic> json) {
    return ContractorProjectOfferModel(
      id: json['id'] as String,
      projectId: json['project_id'] as String,
      contractorId: json['contractor_id'] as String,
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
      'contractor_id': contractorId,
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

  ContractorProjectOfferModel copyWith({
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
    return ContractorProjectOfferModel(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      contractorId: contractorId ?? this.contractorId,
      budgetMin: budgetMin ?? this.budgetMin,
      budgetMax: budgetMax ?? this.budgetMax,
      pesan: pesan ?? this.pesan,
      estimasiWaktu: estimasiWaktu ?? this.estimasiWaktu,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}