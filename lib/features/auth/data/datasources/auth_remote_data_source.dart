import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/exceptions.dart' hide AuthException;
import '../../../../services/supabase_service.dart';
import '../models/user_model.dart';

/// Kontrak data source remote untuk fitur Auth.
abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password, String name);
  Future<void> logout();
  UserModel? getCurrentUser();
}

/// Implementasi AuthRemoteDataSource menggunakan Supabase Auth.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final _client = SupabaseService.client;

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user == null) {
        throw const AuthException('Login gagal: user tidak ditemukan');
      }
      return UserModel.fromSupabaseUser(response.user!);
    } on AuthApiException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );
      if (response.user == null) {
        throw const AuthException('Register gagal');
      }
      return UserModel.fromSupabaseUser(response.user!);
    } on AuthApiException catch (e) {
      throw AuthException(e.message);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _client.auth.signOut();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  UserModel? getCurrentUser() {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabaseUser(user);
  }
}
