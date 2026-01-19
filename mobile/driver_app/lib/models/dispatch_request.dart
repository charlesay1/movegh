class DispatchRequest {
  DispatchRequest({
    required this.id,
    required this.pickup,
    required this.dropoff,
    required this.mode,
    required this.amount,
    required this.currency,
    this.notes,
  });

  final String id;
  final String pickup;
  final String dropoff;
  final String mode;
  final double amount;
  final String currency;
  final String? notes;

  factory DispatchRequest.fromJson(Map<String, dynamic> json) {
    return DispatchRequest(
      id: json["request_id"]?.toString() ?? json["id"]?.toString() ?? "",
      pickup: json["pickup"]?.toString() ?? "",
      dropoff: json["dropoff"]?.toString() ?? "",
      mode: json["mode"]?.toString() ?? "car",
      amount: (json["amount"] as num?)?.toDouble() ?? 0,
      currency: json["currency"]?.toString() ?? "GHS",
      notes: json["notes"]?.toString(),
    );
  }
}
