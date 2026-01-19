import "package:shared_preferences/shared_preferences.dart";

class SessionStore {
  SessionStore._(this._prefs);

  static const _keyLoggedIn = "session_logged_in";
  static const _keyProfileComplete = "profile_complete";
  static const _keyLocationPrompted = "location_prompted";
  static const _keyPhone = "session_phone";
  static const _keyToken = "session_token";
  static const _keyFirstName = "profile_first_name";
  static const _keyLastName = "profile_last_name";
  static const _keyEmail = "profile_email";

  final SharedPreferences _prefs;

  static Future<SessionStore> instance() async {
    final prefs = await SharedPreferences.getInstance();
    return SessionStore._(prefs);
  }

  String? get token => _prefs.getString(_keyToken);
  bool get isLoggedIn => token?.isNotEmpty ?? false;
  bool get isProfileComplete => _prefs.getBool(_keyProfileComplete) ?? false;
  bool get isLocationPrompted => _prefs.getBool(_keyLocationPrompted) ?? false;
  String? get phone => _prefs.getString(_keyPhone);

  Future<void> setLoggedIn(String phone) async {
    await _prefs.setBool(_keyLoggedIn, true);
    await _prefs.setString(_keyPhone, phone);
  }

  Future<void> setSession({required String token, required String phone}) async {
    await _prefs.setString(_keyToken, token);
    await _prefs.setString(_keyPhone, phone);
    await _prefs.setBool(_keyLoggedIn, true);
  }

  Future<void> saveProfile({
    required String firstName,
    String? lastName,
    String? email,
  }) async {
    await _prefs.setString(_keyFirstName, firstName);
    if (lastName != null) {
      await _prefs.setString(_keyLastName, lastName);
    }
    if (email != null) {
      await _prefs.setString(_keyEmail, email);
    }
    await _prefs.setBool(_keyProfileComplete, true);
  }

  Future<void> setLocationPrompted() async {
    await _prefs.setBool(_keyLocationPrompted, true);
  }

  Future<void> clear() async {
    await _prefs.remove(_keyLoggedIn);
    await _prefs.remove(_keyProfileComplete);
    await _prefs.remove(_keyLocationPrompted);
    await _prefs.remove(_keyPhone);
    await _prefs.remove(_keyToken);
    await _prefs.remove(_keyFirstName);
    await _prefs.remove(_keyLastName);
    await _prefs.remove(_keyEmail);
  }
}
