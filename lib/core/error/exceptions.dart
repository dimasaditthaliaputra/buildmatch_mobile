class ServerException implements Exception {
  final String message;
  const ServerException([this.message = 'Terjadi kesalahan pada server']);

  @override
  String toString() => 'ServerException: $message';
}

class CacheException implements Exception {
  final String message;
  const CacheException([this.message = 'Terjadi kesalahan pada cache']);

  @override
  String toString() => 'CacheException: $message';
}

class AuthException implements Exception {
  final String message;
  const AuthException([this.message = 'Terjadi kesalahan autentikasi']);

  @override
  String toString() => 'AuthException: $message';
}
