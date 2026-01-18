import "api_client.dart";
import "auth_service.dart";
import "deliveries_service.dart";
import "payments_service.dart";
import "rides_service.dart";

class AppServices {
  static final ApiClient apiClient = ApiClient();
  static final AuthService auth = AuthService(apiClient);
  static final RidesService rides = RidesService(apiClient);
  static final DeliveriesService deliveries = DeliveriesService(apiClient);
  static final PaymentsService payments = PaymentsService(apiClient);
}
