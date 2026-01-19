import "../app_config.dart";
import "../models/driver_request.dart";
import "api_client.dart";

class DispatchService {
  DispatchService(this._client);

  final ApiClient _client;
  DriverRequest? _mockRequest;

  Future<void> setStatus({required bool online}) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      if (online) {
        _mockRequest ??= const DriverRequest(
          id: "req_001",
          pickup: "Osu Junction",
          dropoff: "East Legon",
          fareGhs: 28.0,
          etaMinutes: 6,
        );
      } else {
        _mockRequest = null;
      }
      return;
    }
    await _client.postJson("/drivers/status", {"online": online});
  }

  Future<DriverRequest?> fetchCurrentRequest() async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return _mockRequest;
    }
    final response = await _client.getJson("/drivers/requests");
    final payload = response["request"];
    if (payload == null) {
      return null;
    }
    return DriverRequest.fromJson(payload as Map<String, dynamic>);
  }

  Future<void> acceptRequest(String requestId) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      _mockRequest = null;
      return;
    }
    await _client.postJson("/drivers/requests/$requestId/accept", {});
  }

  Future<void> rejectRequest(String requestId) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      _mockRequest = null;
      return;
    }
    await _client.postJson("/drivers/requests/$requestId/reject", {});
  }
}
