import "../config/api_endpoints.dart";
import "../config/app_config.dart";
import "api_client.dart";

class PaymentsService {
  PaymentsService(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> chargeWallet(double amount, String method) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {"status": "processing", "reference": "momo_ref_001"};
    }
    return _client.postJson(ApiEndpoints.paymentsCharge, {
      "amount": amount,
      "method": method,
    });
  }
}
