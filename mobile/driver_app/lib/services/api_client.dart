import "dart:convert";
import "package:http/http.dart" as http;
import "../app_config.dart";

class ApiClient {
  String? _token;

  void setToken(String token) {
    _token = token;
  }

  void clearToken() {
    _token = null;
  }

  Uri _uri(String path) {
    return Uri.parse("${AppConfig.baseUrl}$path");
  }

  Map<String, String> _headers() {
    final headers = <String, String>{"Content-Type": "application/json"};
    if (_token != null) {
      headers["Authorization"] = "Bearer $_token";
    }
    return headers;
  }

  Future<Map<String, dynamic>> getJson(String path) async {
    final response = await http.get(_uri(path), headers: _headers());
    return _decode(response);
  }

  Future<Map<String, dynamic>> postJson(String path, Map<String, dynamic> body) async {
    final response = await http.post(
      _uri(path),
      headers: _headers(),
      body: jsonEncode(body),
    );
    return _decode(response);
  }

  Map<String, dynamic> _decode(http.Response response) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 400) {
      final message = decoded["message"]?.toString() ?? "Request failed";
      throw Exception(message);
    }
    return decoded;
  }
}
