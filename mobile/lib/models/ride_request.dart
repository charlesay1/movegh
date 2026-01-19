class RideRequest {
  RideRequest({
    required this.pickup,
    required this.dropoff,
    required this.mode,
    this.notes,
  });

  final String pickup;
  final String dropoff;
  final String mode;
  final String? notes;

  Map<String, dynamic> toJson() => {
        "pickup": pickup,
        "dropoff": dropoff,
        "mode": mode,
        "notes": notes,
      };
}
