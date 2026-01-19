import "../config/api_endpoints.dart";
import "../config/app_config.dart";
import "../models/fare_estimate.dart";
import "../models/ride_request.dart";
import "../models/ride_status.dart";
import "api_client.dart";

class RidesService {
  RidesService(this._client);

  final ApiClient _client;
  final Map<String, int> _mockPolls = {};

  Future<FareEstimate> estimateFare(RideRequest request) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return FareEstimate(
        currency: "GHS",
        amount: 24,
        distanceKm: 5.4,
        durationMin: 14,
      );
    }
    final response = await _client.getJson(
      "${ApiEndpoints.ridesEstimate}?pickup=${request.pickup}&dropoff=${request.dropoff}&mode=${request.mode}",
    );
    return FareEstimate.fromJson(response);
  }

  Future<Map<String, dynamic>> createRide(RideRequest request) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {"ride_id": "ride_001", "status": "requested", "currency": "GHS", "amount": 24};
    }
    return _client.postJson(ApiEndpoints.ridesCreate, request.toJson());
  }

  Future<RideStatus> getRideStatus(String rideId) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      final polls = (_mockPolls[rideId] ?? 0) + 1;
      _mockPolls[rideId] = polls;
      if (polls >= 6) {
        return RideStatus(
          rideId: rideId,
          status: "completed",
          driverName: "Kojo Mensah",
          driverRating: 4.9,
          etaMin: 0,
        );
      }
      if (polls >= 4) {
        return RideStatus(
          rideId: rideId,
          status: "in_progress",
          driverName: "Kojo Mensah",
          driverRating: 4.9,
          etaMin: 2,
        );
      }
      return RideStatus(
        rideId: rideId,
        status: polls >= 2 ? "assigned" : "requested",
        driverName: "Kojo Mensah",
        driverRating: 4.9,
        etaMin: polls >= 2 ? 4 : 6,
      );
    }
    final response = await _client.getJson(ApiEndpoints.rideById(rideId));
    return RideStatus.fromJson(response);
  }

  Future<Map<String, dynamic>> cancelRide(String rideId) async {
    if (AppConfig.useMock) {
      await Future.delayed(const Duration(milliseconds: AppConfig.mockDelayMs));
      return {"status": "cancelled"};
    }
    return _client.postJson(ApiEndpoints.rideCancel(rideId), {});
  }
}
