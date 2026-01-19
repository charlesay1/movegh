class DriverRequest {
  const DriverRequest({
    required this.id,
    required this.pickup,
    required this.dropoff,
    required this.fareGhs,
    required this.etaMinutes,
  });

  final String id;
  final String pickup;
  final String dropoff;
  final double fareGhs;
  final int etaMinutes;

  factory DriverRequest.fromJson(Map<String, dynamic> json) {
    return DriverRequest(
      id: json["id"].toString(),
      pickup: json["pickup"]?.toString() ?? "",
      dropoff: json["dropoff"]?.toString() ?? "",
      fareGhs: (json["fare_ghs"] as num?)?.toDouble() ?? 0,
      etaMinutes: (json["eta_min"] as num?)?.toInt() ?? 0,
    );
  }
}
