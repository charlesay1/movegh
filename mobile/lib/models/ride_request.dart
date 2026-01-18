class RideRequest {
  RideRequest({
    required this.pickup,
    required this.dropoff,
    required this.mode,
  });

  final String pickup;
  final String dropoff;
  final String mode;

  Map<String, dynamic> toJson() => {
        "pickup": pickup,
        "dropoff": dropoff,
        "mode": mode,
      };
}
