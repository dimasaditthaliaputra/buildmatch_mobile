
import 'package:buildmatch_mobile/features/architect/domain/entities/architect_milestone_entity.dart';

class ArchitectMilestoneModel extends ArchitectMilestoneEntity {
  const ArchitectMilestoneModel({
    required super.id,
    required super.nama,
    required super.persentase,
    required super.jumlahUang,
    super.deadline,
    required super.tipe,
    super.isFromSystem,
  });

  factory ArchitectMilestoneModel.fromJson(Map<String, dynamic> json) {
    return ArchitectMilestoneModel(
      id: json['id'] as String,
      nama: json['nama'] as String,
      persentase: (json['persentase'] as num).toDouble(),
      jumlahUang: (json['jumlah_uang'] as num).toDouble(),
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'] as String)
          : null,
      tipe: _tipeFromString(json['tipe'] as String? ?? 'non_pembangunan'),
      isFromSystem: json['is_from_system'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'persentase': persentase,
      'jumlah_uang': jumlahUang,
      'deadline': deadline?.toIso8601String(),
      'tipe': tipe == MilestoneTipe.pembangunan ? 'pembangunan' : 'non_pembangunan',
      'is_from_system': isFromSystem,
    };
  }

  static MilestoneTipe _tipeFromString(String tipe) {
    switch (tipe) {
      case 'pembangunan':
        return MilestoneTipe.pembangunan;
      case 'non_pembangunan':
      default:
        return MilestoneTipe.nonPembangunan;
    }
  }

  factory ArchitectMilestoneModel.fromEntity(ArchitectMilestoneEntity entity) {
    return ArchitectMilestoneModel(
      id: entity.id,
      nama: entity.nama,
      persentase: entity.persentase,
      jumlahUang: entity.jumlahUang,
      deadline: entity.deadline,
      tipe: entity.tipe,
      isFromSystem: entity.isFromSystem,
    );
  }
}
