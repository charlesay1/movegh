import "../models/dispatch_request.dart";
import "api_client.dart";

class DriverService {
  DriverService(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> setStatus({required String driverId, required bool online}) async {
    return _client.postJson("/drivers/status", {
      "driver_id": driverId,
      "status": online ? "online" : "offline",
    });
  }

  Future<List<DispatchRequest>> getRequests() async {
    final response = await _client.getJson("/drivers/requests");
    final items = response["requests"] as List<dynamic>? ??
        (response["request_id"] != null ? [response] : <dynamic>[]);
    return items
        .map((item) => DispatchRequest.fromJson(item as Map<String, dynamic>))
        .where((item) => item.id.isNotEmpty)
        .toList();
  }

  Future<DispatchRequest?> getRequest(String requestId) async {
    final response = await _client.getJson("/drivers/requests/$requestId");
    if (response["request_id"] == null && response["id"] == null) {
      return null;
    }
    return DispatchRequest.fromJson(response);
  }

  Future<Map<String, dynamic>> acceptRequest(String requestId) async {
    return _client.postJson("/drivers/requests/$requestId/accept", {});
  }

  Future<Map<String, dynamic>> rejectRequest(String requestId) async {
    return _client.postJson("/drivers/requests/$requestId/reject", {});
  }

  Future<Map<String, dynamic>> arriveRequest(String requestId) async {
    return _client.postJson("/drivers/requests/$requestId/arrive", {});
  }

  Future<Map<String, dynamic>> startTrip(String requestId) async {
    return _client.postJson("/drivers/requests/$requestId/start", {});
  }

  Future<Map<String, dynamic>> completeTrip(String requestId) async {
    return _client.postJson("/drivers/requests/$requestId/complete", {});
  }
}
