class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    "MOVEGH_API_BASE_URL",
    defaultValue: "http://localhost:3000/v1",
  );

  static const bool useMock = bool.fromEnvironment(
    "MOVEGH_USE_MOCK",
    defaultValue: false,
  );

  static const int mockDelayMs = 400;
  static const int apiTimeoutMs = 8000;
}
