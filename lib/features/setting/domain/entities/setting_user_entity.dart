import 'package:equatable/equatable.dart';

class SettingUserEntity extends Equatable {
  final String id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final String? address;
  final int? roleId;
  final String? roleName; // 'client', 'arsitek', 'kontraktor'

  const SettingUserEntity({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    this.address,
    this.roleId,
    this.roleName,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        fullName,
        avatarUrl,
        phoneNumber,
        address,
        roleId,
        roleName,
      ];

  SettingUserEntity copyWith({
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    String? phoneNumber,
    String? address,
    int? roleId,
    String? roleName,
  }) {
    return SettingUserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      roleId: roleId ?? this.roleId,
      roleName: roleName ?? this.roleName,
    );
  }
}
