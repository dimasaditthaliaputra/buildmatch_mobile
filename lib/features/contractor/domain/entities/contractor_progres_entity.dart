class ContractorProgressEntity {
  final String jenisPekerjaanId;
  final String jenisPekerjaanNama;
  final double persentase;
  final bool isDariSistem;

  const ContractorProgressEntity({
    required this.jenisPekerjaanId,
    required this.jenisPekerjaanNama,
    required this.persentase,
    required this.isDariSistem,
  });
}

class JenisPekerjaanEntity {
  final String id;
  final String nama;
  final double persentaseOtomatis;

  const JenisPekerjaanEntity({
    required this.id,
    required this.nama,
    required this.persentaseOtomatis,
  });
}