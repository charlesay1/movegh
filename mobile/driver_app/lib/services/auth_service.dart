import "api_client.dart";

class AuthService {
  AuthService(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> requestOtp(String phone) async {
    return _client.postJson("/auth/otp/request", {"phone": phone});
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    return _client.postJson("/auth/otp/verify", {"phone": phone, "code": code});
  }
}
