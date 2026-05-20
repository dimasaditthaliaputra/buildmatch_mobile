import '../../domain/entities/contractor_progres_entity.dart';

class JenisPekerjaanModel extends JenisPekerjaanEntity {
  const JenisPekerjaanModel({
    required super.id,
    required super.nama,
    required super.persentaseOtomatis,
  });

  factory JenisPekerjaanModel.fromJson(Map<String, dynamic> json) {
    return JenisPekerjaanModel(
      id: json['id'] as String,
      nama: json['nama'] as String,
      persentaseOtomatis: (json['persentase_otomatis'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'persentase_otomatis': persentaseOtomatis,
      };
}

class ContractorProgresModel extends ContractorProgressEntity {
  const ContractorProgresModel({
    required super.jenisPekerjaanId,
    required super.jenisPekerjaanNama,
    required super.persentase,
    required super.isDariSistem,
  });

  factory ContractorProgresModel.fromJson(Map<String, dynamic> json) {
    return ContractorProgresModel(
      jenisPekerjaanId: json['jenis_pekerjaan_id'] as String,
      jenisPekerjaanNama: json['jenis_pekerjaan_nama'] as String,
      persentase: (json['persentase'] as num).toDouble(),
      isDariSistem: json['is_dari_sistem'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
        'jenis_pekerjaan_id': jenisPekerjaanId,
        'jenis_pekerjaan_nama': jenisPekerjaanNama,
        'persentase': persentase,
        'is_dari_sistem': isDariSistem,
      };
}