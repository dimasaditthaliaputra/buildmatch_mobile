enum MilestoneTipe { pembangunan, nonPembangunan }

enum MilestoneInputMode { dariSistem, manual }

class ContractorMilestoneEntity {
  final String id;
  final String nama;
  final double persentase; // 0.0 – 1.0
  final double jumlahUang;
  final DateTime? deadline;
  final MilestoneTipe tipe;
  final bool isFromSystem;

  const ContractorMilestoneEntity({
    required this.id,
    required this.nama,
    required this.persentase,
    required this.jumlahUang,
    this.deadline,
    required this.tipe,
    this.isFromSystem = false,
  });

  ContractorMilestoneEntity copyWith({
    String? id,
    String? nama,
    double? persentase,
    double? jumlahUang,
    DateTime? deadline,
    MilestoneTipe? tipe,
    bool? isFromSystem,
  }) {
    return ContractorMilestoneEntity(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      persentase: persentase ?? this.persentase,
      jumlahUang: jumlahUang ?? this.jumlahUang,
      deadline: deadline ?? this.deadline,
      tipe: tipe ?? this.tipe,
      isFromSystem: isFromSystem ?? this.isFromSystem,
    );
  }
}
