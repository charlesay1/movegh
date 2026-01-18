class DeliveryRequest {
  DeliveryRequest({
    required this.pickup,
    required this.dropoff,
    required this.packageSize,
    required this.notes,
  });

  final String pickup;
  final String dropoff;
  final String packageSize;
  final String notes;

  Map<String, dynamic> toJson() => {
        "pickup": pickup,
        "dropoff": dropoff,
        "package_size": packageSize,
        "notes": notes,
      };
}
