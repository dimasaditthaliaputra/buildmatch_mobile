/// Placeholder untuk local data source (cache token, dsb).
/// Implementasi bisa menggunakan SharedPreferences atau Hive.
abstract class AuthLocalDataSource {
  Future<void> cacheToken(String token);
  Future<String?> getCachedToken();
  Future<void> clearCache();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // TODO: Inject SharedPreferences/Hive di sini

  @override
  Future<void> cacheToken(String token) async {
    // TODO: Implement cache token
  }

  @override
  Future<String?> getCachedToken() async {
    // TODO: Implement get cached token
    return null;
  }

  @override
  Future<void> clearCache() async {
    // TODO: Implement clear cache
  }
}
