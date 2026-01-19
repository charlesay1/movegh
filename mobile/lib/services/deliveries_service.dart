import "../config/api_endpoints.dart";
import "../app_config.dart";
import "../models/delivery_request.dart";
import "api_client.dart";

class DeliveriesService {
  DeliveriesService(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> requestDelivery(DeliveryRequest request) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {"delivery_id": "delivery_001", "status": "requested", "currency": "GHS", "amount": 18};
    }
    return _client.postJson(ApiEndpoints.deliveriesRequest, request.toJson());
  }
}
