import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/setting_user_model.dart';

abstract class SettingRemoteDataSource {
  Future<SettingUserModel> getUserProfile();

  Future<SettingUserModel> updateUserProfile({
    required String userId,
    String? fullName,
    String? phoneNumber,
    String? address,
  });
}

class SettingRemoteDataSourceImpl implements SettingRemoteDataSource {
  final SupabaseClient _client;

  // Local persistent mock user for flawless offline/slicing testing
  static SettingUserModel _mockUser = const SettingUserModel(
    id: 'mock-user-123',
    email: 'budi.arsitek@buildmatch.co.id',
    fullName: 'Budi Santoso',
    avatarUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150',
    phoneNumber: '081234567890',
    address: 'Jl. Raya Kebayoran Baru No. 42, Jakarta Selatan',
    roleId: 2,
    roleName: 'arsitek',
  );

  SettingRemoteDataSourceImpl({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  @override
  Future<SettingUserModel> getUserProfile() async {
    try {
      final authUser = _client.auth.currentUser;
      if (authUser == null) {
        return _mockUser;
      }

      final response = await _client
          .from('users')
          .select('*, roles(role_name)')
          .eq('id', authUser.id)
          .single();

      return SettingUserModel.fromJson(response);
    } catch (e) {
      // Fallback to mock user to prevent crash during slicing
      return _mockUser;
    }
  }

  @override
  Future<SettingUserModel> updateUserProfile({
    required String userId,
    String? fullName,
    String? phoneNumber,
    String? address,
  }) async {
    try {
      final authUser = _client.auth.currentUser;
      if (authUser == null || userId == 'mock-user-123') {
        _mockUser = _mockUser.copyWithModel(
          fullName: fullName,
          phoneNumber: phoneNumber,
          address: address,
        );
        return _mockUser;
      }

      final updates = <String, dynamic>{
        'updated_at': DateTime.now().toUtc().toIso8601String(),
      };

      if (fullName != null) updates['full_name'] = fullName;
      if (phoneNumber != null) updates['phone_number'] = phoneNumber;
      if (address != null) updates['address'] = address;

      final response = await _client
          .from('users')
          .update(updates)
          .eq('id', userId)
          .select('*, roles(role_name)')
          .single();

      return SettingUserModel.fromJson(response);
    } catch (e) {
      // Fallback update locally during slicing
      _mockUser = _mockUser.copyWithModel(
        fullName: fullName,
        phoneNumber: phoneNumber,
        address: address,
      );
      return _mockUser;
    }
  }
}
