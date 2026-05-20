class ClientProjectEntity {
  final String id;
  final String name;
  final String location;
  final String startDate;
  final String status; // 'MENUNGGU' | 'BERJALAN' | 'REVIEW' | 'SELESAI'
  final String phase;
  final double progressPercent;
  final String? professionalName; // arsitek or kontraktor name
  final String professionalType; // 'ARSITEK' | 'KONTRAKTOR'
  final String? endDate;

  const ClientProjectEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.startDate,
    required this.status,
    required this.phase,
    required this.progressPercent,
    this.professionalName,
    required this.professionalType,
    this.endDate,
  });

  bool get isWaiting => status == 'MENUNGGU';
  bool get isRunning => status == 'BERJALAN';
  bool get isReview => status == 'REVIEW';
  bool get isDone => status == 'SELESAI';
}
