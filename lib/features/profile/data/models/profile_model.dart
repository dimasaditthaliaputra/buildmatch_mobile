import '../../domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    super.avatarUrl,
    super.name,
    super.phone,
    super.address,
    super.npwpNumber,
    super.npwpFile,
    super.nibNumber,
    super.nibFile,
    super.certificationFile,
    required super.role,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      avatarUrl: json['avatarUrl'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      npwpNumber: json['npwpNumber'] as String?,
      npwpFile: json['npwpFile'] as String?,
      nibNumber: json['nibNumber'] as String?,
      nibFile: json['nibFile'] as String?,
      certificationFile: json['certificationFile'] as String?,
      role: json['role'] as String? ?? 'client',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'avatarUrl': avatarUrl,
      'name': name,
      'phone': phone,
      'address': address,
      'npwpNumber': npwpNumber,
      'npwpFile': npwpFile,
      'nibNumber': nibNumber,
      'nibFile': nibFile,
      'certificationFile': certificationFile,
      'role': role,
    };
  }

  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      avatarUrl: entity.avatarUrl,
      name: entity.name,
      phone: entity.phone,
      address: entity.address,
      npwpNumber: entity.npwpNumber,
      npwpFile: entity.npwpFile,
      nibNumber: entity.nibNumber,
      nibFile: entity.nibFile,
      certificationFile: entity.certificationFile,
      role: entity.role,
    );
  }
}
