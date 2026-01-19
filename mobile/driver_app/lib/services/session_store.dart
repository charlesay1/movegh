import "package:shared_preferences/shared_preferences.dart";

class SessionStore {
  SessionStore._(this._prefs);

  static const _keyToken = "driver_token";
  static const _keyPhone = "driver_phone";

  final SharedPreferences _prefs;

  static Future<SessionStore> instance() async {
    final prefs = await SharedPreferences.getInstance();
    return SessionStore._(prefs);
  }

  String? get token => _prefs.getString(_keyToken);
  String? get phone => _prefs.getString(_keyPhone);

  Future<void> setSession({required String token, required String phone}) async {
    await _prefs.setString(_keyToken, token);
    await _prefs.setString(_keyPhone, phone);
  }

  Future<void> clear() async {
    await _prefs.remove(_keyToken);
    await _prefs.remove(_keyPhone);
  }
}
