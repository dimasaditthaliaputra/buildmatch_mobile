import 'package:shared_preferences/shared_preferences.dart';

/// Wrapper sederhana untuk akses SharedPreferences.
class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  // ── String ──
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);
  String? getString(String key) => _prefs.getString(key);

  // ── Bool ──
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);
  bool? getBool(String key) => _prefs.getBool(key);

  // ── Remove ──
  Future<bool> remove(String key) => _prefs.remove(key);

  // ── Clear all ──
  Future<bool> clear() => _prefs.clear();
}
