import "../app_config.dart";
import "api_client.dart";

class AuthService {
  AuthService(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> requestOtp(String phone) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {"status": "sent", "ttl_sec": 180};
    }
    return _client.postJson("/auth/otp/request", {"phone": phone});
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {
        "status": "verified",
        "token": "mock_driver_token",
        "refresh_token": "mock_refresh_token",
        "driver": {"id": "driver_001", "phone": phone, "name": "Driver Mensah"},
      };
    }
    return _client.postJson("/auth/otp/verify", {"phone": phone, "code": code});
  }
}
