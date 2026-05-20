class PortofolioEntity {
  final String id;
  final String judul;
  final String deskripsi;
  final List<String> imagePaths;
  final DateTime createdAt;

  const PortofolioEntity({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.imagePaths,
    required this.createdAt,
  });
}
