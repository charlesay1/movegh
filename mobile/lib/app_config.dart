class AppConfig {
  static const String apiBaseUrl = String.fromEnvironment(
    "MOVEGH_API_BASE_URL",
    defaultValue: "http://127.0.0.1:3000",
  );

  static const bool useMock = bool.fromEnvironment(
    "MOVEGH_USE_MOCK",
    defaultValue: false,
  );

  static const int mockDelayMs = 400;
}
