import '../../domain/entities/setting_user_entity.dart';

class SettingUserModel extends SettingUserEntity {
  const SettingUserModel({
    required String id,
    required String email,
    String? fullName,
    String? avatarUrl,
    String? phoneNumber,
    String? address,
    int? roleId,
    String? roleName,
  }) : super(
          id: id,
          email: email,
          fullName: fullName,
          avatarUrl: avatarUrl,
          phoneNumber: phoneNumber,
          address: address,
          roleId: roleId,
          roleName: roleName,
        );

  factory SettingUserModel.fromJson(Map<String, dynamic> json) {
    // 'roles' is the joined table; role_name is inside it.
    final rolesMap = json['roles'] as Map<String, dynamic>?;
    final rawRoleName = rolesMap?['role_name'] as String?;

    return SettingUserModel(
      id: json['id'] as String,
      email: json['email'] as String? ?? '',
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      phoneNumber: json['phone_number'] as String?,
      address: json['address'] as String?,
      roleId: json['role_id'] as int?,
      roleName: _normalizeRoleName(rawRoleName),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'phone_number': phoneNumber,
      'address': address,
      'role_id': roleId,
    };
  }

  /// Converts Supabase role_name (e.g. "Arsitek") → lowercase slug used in the app.
  static String? _normalizeRoleName(String? raw) {
    if (raw == null) return null;
    final lower = raw.toLowerCase();
    if (lower.contains('arsitek')) return 'arsitek';
    if (lower.contains('kontraktor') || lower.contains('contractor')) {
      return 'kontraktor';
    }
    return 'client';
  }

  SettingUserModel copyWithModel({
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    String? phoneNumber,
    String? address,
    int? roleId,
    String? roleName,
  }) {
    return SettingUserModel(
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
