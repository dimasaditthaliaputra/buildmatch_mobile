import '../../domain/entities/portofolio_entity.dart';

class PortofolioModel extends PortofolioEntity {
  const PortofolioModel({
    required super.id,
    required super.judul,
    required super.deskripsi,
    required super.imagePaths,
    required super.createdAt,
  });

  factory PortofolioModel.fromJson(Map<String, dynamic> json) {
    return PortofolioModel(
      id: json['id'] as String,
      judul: json['judul'] as String,
      deskripsi: json['deskripsi'] as String,
      imagePaths: List<String>.from(json['image_paths'] ?? []),
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'judul': judul,
      'deskripsi': deskripsi,
      'image_paths': imagePaths,
      'created_at': createdAt.toIso8601String(),
    };
  }

  PortofolioModel copyWith({
    String? id,
    String? judul,
    String? deskripsi,
    List<String>? imagePaths,
    DateTime? createdAt,
  }) {
    return PortofolioModel(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      deskripsi: deskripsi ?? this.deskripsi,
      imagePaths: imagePaths ?? this.imagePaths,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
