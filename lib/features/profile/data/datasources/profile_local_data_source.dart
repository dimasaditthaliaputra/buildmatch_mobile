import '../models/profile_model.dart';

abstract class ProfileLocalDataSource {
  Future<void> saveProfile(ProfileModel profile);
  Future<ProfileModel?> getProfile();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileModel? _cachedProfile;

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    // Simulate minor network/disk IO latency
    await Future.delayed(const Duration(milliseconds: 1000));
    _cachedProfile = profile;
  }

  @override
  Future<ProfileModel?> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _cachedProfile;
  }
}
