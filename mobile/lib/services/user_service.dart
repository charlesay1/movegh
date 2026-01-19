import "../app_config.dart";
import "../config/api_endpoints.dart";
import "api_client.dart";

class UserService {
  UserService(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> updateProfile({
    required String firstName,
    String? lastName,
    String? email,
  }) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {"status": "updated"};
    }
    final payload = <String, dynamic>{"first_name": firstName};
    if (lastName != null) {
      payload["last_name"] = lastName;
    }
    if (email != null) {
      payload["email"] = email;
    }
    return _client.patchJson(ApiEndpoints.usersMe, payload);
  }
}
