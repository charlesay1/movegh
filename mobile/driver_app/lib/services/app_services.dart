import "api_client.dart";
import "auth_service.dart";
import "dispatch_service.dart";

class AppServices {
  static final ApiClient apiClient = ApiClient();
  static final AuthService auth = AuthService(apiClient);
  static final DispatchService dispatch = DispatchService(apiClient);
}
