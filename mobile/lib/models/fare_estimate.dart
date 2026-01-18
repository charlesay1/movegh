class FareEstimate {
  FareEstimate({
    required this.currency,
    required this.amount,
    required this.distanceKm,
    required this.durationMin,
  });

  final String currency;
  final double amount;
  final double distanceKm;
  final int durationMin;

  factory FareEstimate.fromJson(Map<String, dynamic> json) {
    return FareEstimate(
      currency: json["currency"] as String? ?? "GHS",
      amount: (json["amount"] as num?)?.toDouble() ?? 0,
      distanceKm: (json["distance_km"] as num?)?.toDouble() ?? 0,
      durationMin: (json["duration_min"] as num?)?.toInt() ?? 0,
    );
  }
}
