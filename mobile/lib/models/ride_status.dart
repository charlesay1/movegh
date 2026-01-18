class RideStatus {
  RideStatus({
    required this.rideId,
    required this.status,
    this.driverName,
    this.driverRating,
    this.etaMin,
  });

  final String rideId;
  final String status;
  final String? driverName;
  final double? driverRating;
  final int? etaMin;

  factory RideStatus.fromJson(Map<String, dynamic> json) {
    final driver = json["driver"] as Map<String, dynamic>?;
    return RideStatus(
      rideId: json["ride_id"] as String? ?? "",
      status: json["status"] as String? ?? "unknown",
      driverName: driver?["name"] as String?,
      driverRating: (driver?["rating"] as num?)?.toDouble(),
      etaMin: (json["eta_min"] as num?)?.toInt(),
    );
  }
}
