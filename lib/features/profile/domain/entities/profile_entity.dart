import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String? avatarUrl;
  final String? name;
  final String? phone;
  final String? address;
  final String? npwpNumber;
  final String? npwpFile;
  final String? nibNumber;
  final String? nibFile;
  final String? certificationFile;
  final String role;

  const ProfileEntity({
    this.avatarUrl,
    this.name,
    this.phone,
    this.address,
    this.npwpNumber,
    this.npwpFile,
    this.nibNumber,
    this.nibFile,
    this.certificationFile,
    required this.role,
  });

  @override
  List<Object?> get props => [
        avatarUrl,
        name,
        phone,
        address,
        npwpNumber,
        npwpFile,
        nibNumber,
        nibFile,
        certificationFile,
        role,
      ];
}
