import "../config/api_endpoints.dart";
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
    return _client.postJson(ApiEndpoints.otpRequest, {"phone": phone});
  }

  Future<Map<String, dynamic>> verifyOtp(String phone, String code) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {
        "status": "verified",
        "token": "mock_access_token",
        "refresh_token": "mock_refresh_token",
        "user": {"id": "user_001", "phone": phone, "name": "Yaw Mensah"},
      };
    }
    return _client.postJson(ApiEndpoints.otpVerify, {"phone": phone, "code": code});
  }
}
