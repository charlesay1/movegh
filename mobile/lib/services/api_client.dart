import "dart:convert";
import "package:http/http.dart" as http;
import "../config/app_config.dart";

class ApiClient {
  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  Future<Map<String, dynamic>> getJson(String path) async {
    final response = await _client.get(
      Uri.parse("${AppConfig.apiBaseUrl}$path"),
      headers: _headers(),
    );
    return _decode(response);
  }

  Future<Map<String, dynamic>> postJson(String path, Map<String, dynamic> body) async {
    final response = await _client.post(
      Uri.parse("${AppConfig.apiBaseUrl}$path"),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Map<String, String> _headers() {
    final headers = <String, String>{"Content-Type": "application/json"};
    if (_token != null && _token!.isNotEmpty) {
      headers["Authorization"] = "Bearer $_token";
    }
    return headers;
  }

  Map<String, dynamic> _decode(http.Response response) {
    final data = response.body.isNotEmpty
        ? jsonDecode(response.body) as Map<String, dynamic>
        : <String, dynamic>{};
    if (response.statusCode >= 400) {
      throw Exception(data["error"] ?? "Request failed");
    }
    return data;
  }
}
