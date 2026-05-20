class ContractorProjectOfferEntity {
  final String id;
  final String projectId;
  final String contractorId;
  final int budgetMin;
  final int budgetMax;
  final String pesan;
  final DateTime estimasiWaktu;
  final PenawaranStatus status;
  final DateTime createdAt;

  const ContractorProjectOfferEntity({
    required this.id,
    required this.projectId,
    required this.contractorId,
    required this.budgetMin,
    required this.budgetMax,
    required this.pesan,
    required this.estimasiWaktu,
    this.status = PenawaranStatus.menunggu,
    required this.createdAt,
  });
}

enum PenawaranStatus {
  menunggu,
  diterima,
  ditolak,
}