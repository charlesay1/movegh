import "dart:async";
import "package:flutter/foundation.dart";
import "../models/fare_estimate.dart";
import "../models/ride_request.dart";
import "../models/ride_status.dart";
import "../services/rides_service.dart";

enum RidePhase {
  idle,
  estimating,
  requesting,
  requested,
  assigned,
  arrived,
  inProgress,
  completed,
  cancelled,
  error,
}

class RideFlowController extends ChangeNotifier {
  RideFlowController(this._ridesService);

  final RidesService _ridesService;
  FareEstimate? _estimate;
  RideStatus? _status;
  RidePhase _phase = RidePhase.idle;
  Timer? _poller;
  String? _error;

  FareEstimate? get estimate => _estimate;
  RideStatus? get status => _status;
  RidePhase get phase => _phase;
  String? get error => _error;

  bool get hasActiveRide => _status?.rideId.isNotEmpty ?? false;

  Future<void> estimateFare(RideRequest request) async {
    _phase = RidePhase.estimating;
    _error = null;
    notifyListeners();
    try {
      _estimate = await _ridesService.estimateFare(request);
      _phase = RidePhase.idle;
    } catch (error) {
      _error = "Unable to estimate fare";
      _phase = RidePhase.error;
    }
    notifyListeners();
  }

  Future<void> createRide(RideRequest request) async {
    _phase = RidePhase.requesting;
    _error = null;
    notifyListeners();
    try {
      final response = await _ridesService.createRide(request);
      final rideId = response["ride_id"] as String? ?? "";
      if (rideId.isNotEmpty) {
        setRideId(rideId);
        await refreshStatus();
      } else {
        _error = "Ride request failed";
        _phase = RidePhase.error;
      }
    } catch (error) {
      _error = "Unable to request ride";
      _phase = RidePhase.error;
    }
    notifyListeners();
  }

  Future<void> refreshStatus() async {
    if (_status?.rideId.isNotEmpty != true) {
      return;
    }
    try {
      final data = await _ridesService.getRideStatus(_status!.rideId);
      _status = data;
      _phase = _mapPhase(data.status);
    } catch (_) {
      _error = "Unable to refresh status";
      _phase = RidePhase.error;
    }
    notifyListeners();
  }

  void startPolling() {
    _poller?.cancel();
    _poller = Timer.periodic(const Duration(seconds: 5), (_) => refreshStatus());
  }

  void stopPolling() {
    _poller?.cancel();
    _poller = null;
  }

  Future<void> cancelRide() async {
    if (_status?.rideId.isNotEmpty != true) {
      return;
    }
    _error = null;
    notifyListeners();
    try {
      await _ridesService.cancelRide(_status!.rideId);
      _phase = RidePhase.cancelled;
    } catch (_) {
      _error = "Unable to cancel ride";
      _phase = RidePhase.error;
    }
    notifyListeners();
  }

  void setRideId(String rideId) {
    _status = RideStatus(rideId: rideId, status: "requested");
    _phase = RidePhase.requested;
    notifyListeners();
  }

  RidePhase _mapPhase(String status) {
    switch (status) {
      case "requested":
        return RidePhase.requested;
      case "assigned":
        return RidePhase.assigned;
      case "arrived":
        return RidePhase.arrived;
      case "in_progress":
        return RidePhase.inProgress;
      case "completed":
        return RidePhase.completed;
      case "cancelled":
        return RidePhase.cancelled;
      default:
        return RidePhase.requested;
    }
  }

  @override
  void dispose() {
    _poller?.cancel();
    super.dispose();
  }
}
