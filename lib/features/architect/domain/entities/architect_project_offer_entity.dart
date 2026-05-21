class ArchitectProjectOfferEntity {
  final String id;
  final String projectId;
  final String architectId;
  final int budgetMin;
  final int budgetMax;
  final String pesan;
  final DateTime estimasiWaktu;
  final PenawaranStatus status;
  final DateTime createdAt;

  const ArchitectProjectOfferEntity({
    required this.id,
    required this.projectId,
    required this.architectId,
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